Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291349AbSBMEcy>; Tue, 12 Feb 2002 23:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291352AbSBMEce>; Tue, 12 Feb 2002 23:32:34 -0500
Received: from [63.231.122.81] ([63.231.122.81]:52057 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291349AbSBMEcZ>;
	Tue, 12 Feb 2002 23:32:25 -0500
Date: Tue, 12 Feb 2002 21:31:19 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eugene Chupkin <ace@credit.com>, linux-kernel@vger.kernel.org,
        tmeagher@credit.com
Subject: Re: 2.4.x ram issues?
Message-ID: <20020212213119.A25535@lynx.turbolabs.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Eugene Chupkin <ace@credit.com>, linux-kernel@vger.kernel.org,
	tmeagher@credit.com
In-Reply-To: <Pine.LNX.4.10.10202121726530.683-100000@mail.credit.com> <E16aoic-0003of-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16aoic-0003of-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 13, 2002 at 02:00:22AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2002  02:00 +0000, Alan Cox wrote:
> > I have a problem with high ram support on 2.4.7 to 2.4.17 all behave the
> > same. I have a quad Xeon 700 box with 16gb of ram on an Intel SKA4 board.
> > The ram is all the same 16 1gb PC100 SDRAM modules from Crucial. If I
> > compile the kernel with high ram (64gb) support, my system runs very slow,
> > it takes about 15 minutes for make menuconfig to come up. If I  recompile
> > the kernel with 4gb support, it runs perfectly normal and very fast, but I
> > have 12 gigs that I can't use. Is this a known issue? Is there a fix? I
> > tried just about everything and I am all out of options. Please help!
> 
> Thats almost certainly indicating that the memory type range registers
> were not set up correcly by the BIOS. Check /proc/mtrr and also ask your
> vendor about BIOS updates to address the problem

The other possibility with that much RAM is that the page tables are taking
up all of the low RAM.  Andrea has a patch to put the page tables into
higmem in the recent -aa kernels.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

