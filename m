Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUHHPTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUHHPTR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 11:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUHHPTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 11:19:16 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:4264 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265510AbUHHPTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 11:19:15 -0400
Subject: dynamic /dev security hole?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Content-Type: text/plain
Organization: 
Message-Id: <1091969260.5759.125.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Aug 2004 08:47:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose I have access to a device, for whatever legit
reason. Maybe I'm given access to a USB key with
some particular serial number.

I hard link this to somewhere else. Never mind that an
admin could in theory use 42 separate partitions and
mount most of the system with the "nodev" option. This
is rarely done.

Now the device is removed. The /dev entry goes away.
A new device is added, and it gets the same device
number as the device I had legit access to. Hmmm?

I should mention open file descriptors too, though I
think the transition away from doing dev_t lookups in
the read()/write()/etc. code has taken care of that.


