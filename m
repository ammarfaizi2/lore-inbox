Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWGITQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWGITQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWGITQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:16:17 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:48390 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1161066AbWGITQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:16:16 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] spinlocks: remove 'volatile'
Date: Sun, 9 Jul 2006 12:16:15 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <44B0FAD5.7050002@argo.co.il>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 09 Jul 2006 12:11:32 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 09 Jul 2006 12:11:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Volatile is useful for non device driver work, for example VJ-style
> channels.  A portable volatile can help to code such things in a
> compiler-neutral and platform-neutral way.  Linux doesn't care about
> compiler neutrality, being coded in GNU C, and about platform
> neutrality, having a per-arch abstraction layer, but other programs may
> wish to run on multiple compilers and multiple platforms without
> per-platform glue layers.

	There is a portable volatile, it's called 'pthread_mutex_lock'. It allows
you to code such things in a compiler-neutral and platform-neutral way. You
don't have to worry about what the compiler might do, what the hardware
might do, what atomic operations the CPU supports, or anything like that.
The atomicity issues I've mentioned in my other posts make any attempt at
creating a 'portable volatile' for shared memory more or less doomed from
the start.

	DS


