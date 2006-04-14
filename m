Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWDNOTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWDNOTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWDNOTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:19:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:491 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751251AbWDNOTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:19:38 -0400
Subject: Re: Direct writing to the IDE on panic?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1144936547.1336.20.camel@localhost.localdomain>
References: <1144936547.1336.20.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Apr 2006 15:28:34 +0100
Message-Id: <1145024914.17531.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-04-13 at 09:55 -0400, Steven Rostedt wrote:
> Hi,
> 
> I was wondering if anyone has done some work to directly write and poll
> to the IDE?  This is to store data on a panic or oops.  So it would need
> to bypass pretty much all the normal Linux mechanisms to do low lever
> IDE work.

I've seen some 2.4 work here. For 2.6 the current focus is kexec of
course

> Obviously, this would be a slow process, but the system has crashed and
> we care more about retrieving information than speed.
> 
> Has this already been done and what issues need to be addressed?

The big issue is 'how am I sure the partition data and code I run are
valid post crash'. You don't want the risk of dumping to the wrong part
of the disk and making a crash into a disaster.


