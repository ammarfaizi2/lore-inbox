Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319653AbSH3TVC>; Fri, 30 Aug 2002 15:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319654AbSH3TVC>; Fri, 30 Aug 2002 15:21:02 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:2813 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S319653AbSH3TVB>; Fri, 30 Aug 2002 15:21:01 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 30 Aug 2002 13:22:54 -0600
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20020830192254.GA32468@clusterfs.com>
Mail-Followup-To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>,
	linux-kernel@vger.kernel.org
References: <180577A42806D61189D30008C7E632E8793A25@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180577A42806D61189D30008C7E632E8793A25@boca213a.boca.ssc.siemens.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2002  14:43 -0400, Bloch, Jack wrote:
> I have an embedded system runing a 2.4.18-3 Kernel. It runs from a 256MB
> compact flash disk (emulates an IDE interface). I am using an EXT2
> filesystem. During some power-off/power-on testing, the disk check failed.
> It dropped me to a shell and I had to run e2fsck -cfv to correct this
> problem. This is all good and well in a lab environment, but in reality,
> there is nobody there to perform the repair (running system is not equipped
> with keyboard and monitor). Is there any way to invoke e2fsck automatically
> or inhibit the failure detection mechanism? Please CC me directly on any
> responses.

I would instead suggest using a filesystem like JFFS2 for flash devices.
This is journaled like ext3, but it also has the benefit of doing wear
levelling on the device, which otherwise will probably wear out the
superblock part of the flash rather quickly.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

