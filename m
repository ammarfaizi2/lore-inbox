Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286412AbRL0SAs>; Thu, 27 Dec 2001 13:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286407AbRL0SAj>; Thu, 27 Dec 2001 13:00:39 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:60664 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S286401AbRL0SA3>;
	Thu, 27 Dec 2001 13:00:29 -0500
Date: Thu, 27 Dec 2001 11:00:09 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: snpe <snpe@snpe.co.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2/ext3  question ?
Message-ID: <20011227110009.C12868@lynx.no>
Mail-Followup-To: snpe <snpe@snpe.co.yu>, linux-kernel@vger.kernel.org
In-Reply-To: <200112272249.fBRMmWm01937@spnew.snpe.co.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200112272249.fBRMmWm01937@spnew.snpe.co.yu>; from snpe@snpe.co.yu on Thu, Dec 27, 2001 at 11:48:31PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2001  23:48 +0100, snpe wrote:
> Hello,
>    I set S flag with chattr for any file.
>    Is file really async write (without buffer cache) ?

No, see chattr man page: S = synchronous updates.  It doesn't say anything
about not using the buffer cache.  You need to use O_DIRECT for that.

>    Is it same raw devices and if not, what is different ?

Totally unrelated.  It means that each I/O is waited on by the kernel
before it returns to user space.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

