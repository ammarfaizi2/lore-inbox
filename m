Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273252AbTHKSzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273184AbTHKSyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:54:49 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:64188 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272975AbTHKSxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:53:18 -0400
Date: Mon, 11 Aug 2003 20:53:27 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, gaxt@rogers.com, henrik@fangorn.dk,
       romieu@fr.zoreil.com, linux-kernel@vger.kernel.org,
       felipe_alfaro@linuxmail.org, babydr@baby-dragons.com,
       len.brown@intel.com
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030811185326.GB25186@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Norbert Preining <preining@logic.at>,
	Andrew Morton <akpm@osdl.org>, gaxt@rogers.com, henrik@fangorn.dk,
	romieu@fr.zoreil.com, linux-kernel@vger.kernel.org,
	felipe_alfaro@linuxmail.org, babydr@baby-dragons.com,
	len.brown@intel.com
References: <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com> <20030810211745.GA5327@gamma.logic.tuwien.ac.at> <20030810154343.351aa69d.akpm@osdl.org> <20030811053437.GA19040@gamma.logic.tuwien.ac.at> <20030811145940.GF4562@www.13thfloor.at> <20030811154009.GE6763@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030811154009.GE6763@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Norbert!

your config seems reasonable to me ...

> I tells me all the usual stuff concerning that it finds 
> the controllers (VIA and HPT) and disks/cdroms, but than 
> hangs with
>        cannot mount rootfs "NULL" or hdb1

AFAIK, there is no such message in 2.6.0-test3 ...

if, on the other hand, the message looks like ...

-----------
VFS: Cannot open root device "hdb1" or unknown-block(0,0)
Please append a correct "root=" boot option
-----------

then this means that "hdb1" was the device given at
the kenel command line (as root=/dev/hdb1) and the
'unknown-block(0,0)' is the major/minor the kernel 
recognized ...

you should pay special attention to the disc/partition
discovery done by the IDE subsystem ...

-----------
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 65537 sectors (33 MB) w/256KiB Cache, CHS=65/16/63
hda: hda1 
hdb: 131074 sectors (67 MB) w/256KiB Cache, CHS=130/16/63
hdb: hdb1 hdb2 hdb3
...
-----------

maybe you could attach a serial console (line)
and capture the boot process, and report it ...

HTH,
Herbert

