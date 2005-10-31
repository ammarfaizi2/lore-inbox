Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVJaX67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVJaX67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVJaX67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:58:59 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:58288 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964896AbVJaX66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:58:58 -0500
Date: Tue, 1 Nov 2005 00:58:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       torvalds@osdl.org, tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
In-Reply-To: <200510310341.02897.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0511010039370.1387@scrub.home>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org>
 <200510310341.02897.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Oct 2005, Andi Kleen wrote:

> I agree regressions are a problem and need to be addressed, but handling all 
> non regressions on a non trivial platforms is just impossible IMHO...

Here is a different kind of non trivial regression on a common platform:

$ ll -S /boot/ | grep ...
-rw-r--r--  1 root root 1518317 2005-11-01 00:38 vmlinuz-2.6.14
-rw-r--r--  1 root root 1506432 2005-08-30 00:36 vmlinuz-2.6.13
-rw-r--r--  1 root root 1451154 2004-12-26 16:54 vmlinuz-2.6.10
-rw-r--r--  1 root root 1432032 2005-06-26 03:50 vmlinuz-2.6.12
-rw-r--r--  1 root root 1413888 2004-06-21 18:33 vmlinuz-2.6.7
-rw-r--r--  1 root root 1394801 2004-05-17 22:14 vmlinuz-2.6.5
-rw-r--r--  1 root root 1390233 2004-05-18 01:54 vmlinuz-2.6.6
-rw-r--r--  1 root root 1315050 2003-09-12 22:10 vmlinuz-2.6.0-test5
-rw-r--r--  1 root root 1280189 2003-06-06 01:00 vmlinuz-2.5.70
-rw-r--r--  1 root root  918663 2002-11-11 22:42 vmlinuz-2.5.47
-rw-r--r--  1 root root  887758 2004-02-19 01:24 vmlinuz-2.4.25
-rw-r--r--  1 root root  883868 2003-12-20 21:02 vmlinuz-2.4.23
-rw-r--r--  1 root root  875858 2003-08-26 00:39 vmlinuz-2.4.22
-rw-r--r--  1 root root  859547 2003-02-06 22:35 vmlinuz-2.5.59
-rw-r--r--  1 root root  855092 2003-06-14 02:29 vmlinuz-2.4.21
-rw-r--r--  1 root root  703585 2002-12-19 11:58 vmlinuz-2.4.20
-rw-r--r--  1 root root  700359 2002-08-03 19:57 vmlinuz-2.4.19
-rw-r--r--  1 root root  690106 2001-01-07 23:38 vmlinuz-2.4.0
-rw-r--r--  1 root root  678080 2002-03-02 20:48 vmlinuz-2.4.18
-rw-r--r--  1 root root  641409 2001-02-23 02:53 vmlinuz-2.4.2
-rw-r--r--  1 root root  640950 2001-01-31 01:30 vmlinuz-2.4.1
-rw-r--r--  1 root root  635339 2001-12-22 03:16 vmlinuz-2.4.17
-rw-r--r--  1 root root  632647 2001-12-04 00:37 vmlinuz-2.4.16
-rw-r--r--  1 root root  629787 2001-11-07 22:00 vmlinuz-2.4.14
-rw-r--r--  1 root root  629240 2001-08-11 18:16 vmlinuz-2.4.8
-rw-r--r--  1 root root  628556 2001-07-21 17:06 vmlinuz-2.4.7
-rw-r--r--  1 root root  628386 2001-09-24 00:02 vmlinuz-2.4.10
-rw-r--r--  1 root root  627597 2001-10-20 15:14 vmlinuz-2.4.12
-rw-r--r--  1 root root  626634 2001-07-11 20:22 vmlinuz-2.4.6
-rw-r--r--  1 root root  623325 2001-05-28 01:57 vmlinuz-2.4.5
-rw-r--r--  1 root root  622619 2001-05-01 16:20 vmlinuz-2.4.4
-rw-r--r--  1 root root  611493 2001-04-02 20:44 vmlinuz-2.4.3
-rw-r--r--  1 root root  497523 2001-03-30 18:56 vmlinuz-2.2.19
-rw-r--r--  1 root root  495553 2001-03-25 17:24 vmlinuz-2.2.18

I'm a bit scared of this development and I'm afraid that merging all the 
new features at high speed has become more important than code quality...

bye, Roman
