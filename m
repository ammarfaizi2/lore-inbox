Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUBLCnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 21:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUBLCnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 21:43:11 -0500
Received: from CPE-65-28-18-238.kc.rr.com ([65.28.18.238]:32924 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S263466AbUBLCmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 21:42:50 -0500
Message-ID: <46246.192.168.1.12.1076553774.squirrel@mail.2thebatcave.com>
Date: Wed, 11 Feb 2004 20:42:54 -0600 (CST)
Subject: /proc/partitions not done updating when init is ran?
From: "Nick Bartos" <spam99@2thebatcave.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem where it does not look like /proc/partitions is updated
completely by the time init is ran.

Basically I am booting from a usb flash device, and when I try to run fsck
on the device on boot (using LABEL=, which is necessary since the actual
device cannot be assumed in my config) it fails.  After further
investigation /proc/partitions does not contain any scsi partitions right
when init is starting, but if I do a "sleep 10" before running fsck then
it works fine.

I can of course put that sleep in there but that is ugly and I have no way
of knowing the maximum delay, so if it took too long then it would not
work and I would be screwed...

Isn't /proc/partitions supposted to be finished updating when init starts?
 If this is not a kernel bug (or it won't be fixed for a while), then what
is the deal and how can I fix this cleanly?
