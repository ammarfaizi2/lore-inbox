Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWDMNzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWDMNzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWDMNzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:55:53 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:50907 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964926AbWDMNzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:55:51 -0400
Subject: Direct writing to the IDE on panic?
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 09:55:47 -0400
Message-Id: <1144936547.1336.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering if anyone has done some work to directly write and poll
to the IDE?  This is to store data on a panic or oops.  So it would need
to bypass pretty much all the normal Linux mechanisms to do low lever
IDE work.

So lets say we have a special partition on a hard drive to be reserved
for just this purpose.  Even set it up to be a swap partition.  So on a
system crash, turn off interrupts, stop all other processors, and then
through polling (to avoid interrupt handling), write as much data as
possible about the state of the machine to this special partition.
After a reboot, this data can then be retrieved for review to see why
the system crashed.

Obviously, this would be a slow process, but the system has crashed and
we care more about retrieving information than speed.

Has this already been done and what issues need to be addressed?

Thanks,

-- Steve


