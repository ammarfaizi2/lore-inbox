Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbSL1Vpi>; Sat, 28 Dec 2002 16:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSL1Vpi>; Sat, 28 Dec 2002 16:45:38 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:15856 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S265675AbSL1Vph>; Sat, 28 Dec 2002 16:45:37 -0500
Date: Sat, 28 Dec 2002 14:49:49 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAQ: how to boot with root=LABEL=/
Message-ID: <20021228144949.E2389@schatzie.adilger.int>
Mail-Followup-To: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
References: <3E0DF78D.6060205@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E0DF78D.6060205@kegel.com>; from dank@kegel.com on Sat, Dec 28, 2002 at 11:12:13AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 28, 2002  11:12 -0800, Dan Kegel wrote:
> I'm trying to configure a minimal 2.4.17 to boot
> on my redhat 8 box.  No modules, no sound, nothing fancy at all.
> 
> One problem I'm having is it only works if I boot with root=/dev/hda9
> instead of red hat's usual root=LABEL=/
> I thought I had configured in the proper partition support.
> 
> Can anyone point out what's missing from my .config (or from 2.4.17)
> to allow booting with root=LABEL=/ ?

You are missing a kernel patch.  The LABEL is a function of the filesystem
and not the partition, and the kernel doesn't check the filesystems for
labels...  One option is to just give the right device for root, another
is to add a patch (posted to l-k about 1.5 years ago) which added kernel
support for this, and a third is to add an initrd which figures out the
label in user space and uses that to mount the root fs.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

