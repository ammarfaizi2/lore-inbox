Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSEZQtS>; Sun, 26 May 2002 12:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316215AbSEZQtO>; Sun, 26 May 2002 12:49:14 -0400
Received: from [195.39.17.254] ([195.39.17.254]:51611 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316225AbSEZQs7>;
	Sun, 26 May 2002 12:48:59 -0400
Date: Sun, 26 May 2002 18:18:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Keith Mannthey <kmannth@us.ibm.com>,
        Mohamed Abbas <mohamed.abbas@intel.com>,
        James P Ketrenos <james.p.ketrenos@intel.com>
Subject: checkpoint/restart [was Re: [ANNOUNCE] fastboot mailing list at OSDL: fastboot@lists.osdl.org]
Message-ID: <20020526161852.GA269@elf.ucw.cz>
In-Reply-To: <1022102395.19870.78.camel@andyp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> OSDL has created a mailing list for discussion of various topics
> relating to "fastboot": reducing enterprise system start & restart time.
> 
> Topics of discussion are expected to include:
> 
> 	- kexec
> 	- Two Kernel Monty
> 	- bootimg
> 	- and other similar technology
> 
> Other areas for discussion may include:
> 
> 	- avoiding reprobe of devices,
> 	- fast system initialization after the kernel boots,
> 	- system-wide checkpoint/restart.

Systemwide checkpoint/restart... seems like suspend-to-disk to me...:

suspend-to-disk, but on the end, do not powerdown, but copy
swap/filesytems to spare disks, simulate suspend failure and
continue. On restart, copy back anddo restart. Perhaps with some LVM
magic this can be made acceptable?

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
