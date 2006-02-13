Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWBMITz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWBMITz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWBMITz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:19:55 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:11129 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751235AbWBMITz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:19:55 -0500
Date: Mon, 13 Feb 2006 09:19:51 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsroot doesn't work with intel card since 2.6.12.2/2.6.11
Message-ID: <20060213081951.GA29141@bitwizard.nl>
References: <20060205215455.7622B1C8E46@fisica.ufpr.br> <dsovp4$bqt$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dsovp4$bqt$1@terminus.zytor.com>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 07:52:04PM -0800, H. Peter Anvin wrote:
> Followup to:  <20060205215455.7622B1C8E46@fisica.ufpr.br>
> By author:    carlos@fisica.ufpr.br (Carlos Carvalho)
> In newsgroup: linux.dev.kernel
> >
> > We have several machines with Intel Corp. 82544EI Gigabit Ethernet
> > Controller (Copper) (rev 02), as reported by lspci. They don't manage
> > to mount the rootfs via nfs anymore. I've tried several combinations
> > and the last one that works is 2.6.12.2 using the 2.6.11 version of
> > the driver (simply replacing the files in the tree). 2.6.12.2 with its
> > own driver doesn't work.
> > 
> > There seems to be a pattern: at each version the machine has more
> > difficulty mounting the rootfs. Other machines using other ethercards
> > but with the same server and filesystem work normally.
> > 
> 
> Care to try out the klibc tree?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

What doesn't work? We have a bunch of machines that boot diskless.

zebigbos:~> cat /proc/version 
Linux version 2.6.15 (erik@zebigbos) (gcc version 3.4.2) #1 SMP Tue Jan 17 11:02:22 CET 2006
zebigbos:~> df /
Filesystem            Size  Used Avail Use% Mounted on
numerobis:/data/nfsroot/zebigbos
                       67G   49G   18G  74% /
zebigbos:~> 

As far as I can remember we haven't had any problems in this area for
a long time.

This machine does have a slightly newer ethernet controller: 

0000:02:07.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
0000:02:07.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
