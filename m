Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290237AbSBSVVP>; Tue, 19 Feb 2002 16:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290236AbSBSVVF>; Tue, 19 Feb 2002 16:21:05 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:51955 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290237AbSBSVUt>;
	Tue, 19 Feb 2002 16:20:49 -0500
Date: Tue, 19 Feb 2002 14:20:00 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ENOTTY from ext3 code?
Message-ID: <20020219142000.H25713@lynx.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020219190932.GA274@elf.ucw.cz> <3C72BC0C.821EAB90@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C72BC0C.821EAB90@zip.com.au>; from akpm@zip.com.au on Tue, Feb 19, 2002 at 12:56:44PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 19, 2002  12:56 -0800, Andrew Morton wrote:
> Pavel Machek wrote:
> > ext3/ioctl.c:
> > 
> > ...
> >         return -ENOTTY;
> > 
> > Does it really make sense to return "not a typewriter" from ext3
> > ioctl?
> 
> ERRORS
>        ...
> 
>        ENOTTY The specified request does not apply to the kind of
>               object that the descriptor d references.
> 
> Lots and lots of ioctls return ENOTTY when passed a request
> which they don't understand.  There's probably a great reason
> for this, but I can't immediately think what it might be.

Well, returning ENOTTY for unknown ioctls instead of EINVAL allows you
to distinguish between 'I have no idea what you are asking of me' and
'you passed me the incorrect parameter to this request' in the caller.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

