Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274601AbRITSig>; Thu, 20 Sep 2001 14:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274604AbRITSi0>; Thu, 20 Sep 2001 14:38:26 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:24829 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274601AbRITSiQ>; Thu, 20 Sep 2001 14:38:16 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 20 Sep 2001 12:38:18 -0600
To: Eric Weigle <ehw@lanl.gov>
Cc: nalabi@formail.org, linux-kernel@vger.kernel.org
Subject: Re: qlogic driver , 1Tbyte hard error
Message-ID: <20010920123818.C14526@turbolinux.com>
Mail-Followup-To: Eric Weigle <ehw@lanl.gov>, nalabi@formail.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15k3FD-0005E1-00@the-village.bc.nu> <20010920095056.A21993@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920095056.A21993@lanl.gov>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2001  09:50 -0600, Eric Weigle wrote:
> > The maximum supported file system size under Linux 2.4 is just under 1Tb.
> > The scsi layer gets slightly confused a bit earlier with its printk messages
>
> Is there any particular (that is, technical) reason for this?  A few months
> ago I hit this problem while building a RAID system for our group.  We wanted
> to do software RAID-0 over three hardware RAID-5 arrays (2 by 375G and one
> 525G) and the kernel (2.4.6) had a hissy fit.
> 
> Given the relatively low cost of disk space ($5000/terabyte and on up, see
> http://staff.sdsc.edu/its/terafile/), is this something that will be supported
> in the future?
> 
> If you point me in the right direction I'd be willing to look at this issue.

There is a patch to allow 64-bit block devices - Ben LaHaise or Jens Axbow
put it out about 2 months ago.  I believe it fixes the SCSI midlayer,
and a limited number of drivers.  This is probably a good starting point
(you may need to update the particular SCSI driver you are using).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

