Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280712AbRKTSeE>; Tue, 20 Nov 2001 13:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280967AbRKTSdx>; Tue, 20 Nov 2001 13:33:53 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:18169 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280712AbRKTSdk>;
	Tue, 20 Nov 2001 13:33:40 -0500
Date: Tue, 20 Nov 2001 11:33:17 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jason Tackaberry <tack@auc.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File size limit exceeded with mkfs
Message-ID: <20011120113316.R1308@lynx.no>
Mail-Followup-To: Jason Tackaberry <tack@auc.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1006272138.1263.3.camel@somewhere.auc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1006272138.1263.3.camel@somewhere.auc.ca>; from tack@auc.ca on Tue, Nov 20, 2001 at 11:02:18AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2001  11:02 -0500, Jason Tackaberry wrote:
> I just installed a shiny new 80GB disk as primary slave and decided to
> upgrade to 2.4.14+ext3 patch.  It appears that with this kernel, and
> also with 2.4.15-pre7, when trying to mkfs partitions greater than 2GB,
> I get "file size limit exceeded" and mkfs aborts.  I can successfully
> mkfs partitions <= 2GB.
> 
> I do not have this problem with 2.4.7; all works well.  Wondering if the
> difference was ext3, I tried compiling 2.4.15-pre7 without ext3 support
> and the same problem occured.

Several people have reported problems like this also.  What happens is
that if you are logged on as a user, then su to root, it will fail.  If
you log in directly as root, it will work.

I have looked through the 2.4.14 patch several times, but could not
find anything that might have caused this (I don't have any problems
with 2.4.13, but it may also have to do with my shell, glibc, or
whatever).

Can you please try some intermediate kernels (2.4.10 would be a good
start, because it had some major changes in this area, and then go
forward and back depending whether it works or not).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

