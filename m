Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289239AbSAIIZS>; Wed, 9 Jan 2002 03:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289246AbSAIIZJ>; Wed, 9 Jan 2002 03:25:09 -0500
Received: from 89dyn48.com21.casema.net ([62.234.20.48]:52705 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S289239AbSAIIZA>; Wed, 9 Jan 2002 03:25:00 -0500
Message-Id: <200201090824.JAA25149@cave.bitwizard.nl>
Subject: Re: lseek() on an iso9660 file
In-Reply-To: <a1cn1j$sev$1@cesium.transmeta.com> from "H. Peter Anvin" at "Jan
 7, 2002 09:48:35 am"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 9 Jan 2002 09:24:56 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.3.95.1020107091316.18091A-100000@chaos.analogic.com>
> By author:    "Richard B. Johnson" <root@chaos.analogic.com>
> In newsgroup: linux.dev.kernel
> > 
> > Using Linux 2.4.1 I discovered a problem with lseek on CDROM files
> > (iso9660). I just installed 2.4.17 and found the same problem.
> > 
> > The problem:
> > 
> > (1) A portion of the file, existing on a CDROM,  is read and its the
> >     contents are written to an output file on writable media.
> > 
> > (2) The current input file-position is obtained using
> >     pos = lseek(fd, 0, SEEK_CUR); The value returned is exactly
> >     the expected value.
> > 
> > (3) The rest of the CDROM file is read and written to the output file.
> > 
> > (4) The file-position of the CDROM file is then set back to the saved
> >     position using lseek(fd, pos, SEEK_SET); The value returned is
> >     exactly the expected value.
> > 
> > (5) The CDROM file is then read and its contents are observed to be
> >     scrambled in some strange manner in which word-length groups of
> >     bytes from near the end of the file are interleaved with the
> >     correct bytes. Basically, the file ends up being about twice
> >     as long as the original, with every-other two-byte interval
> >     being filled with bytes from near the end of the file.
> > 
> 
> a) How long is the file?
> b) What is the offset?
> c) What particular iso9660 options (RockRidge, Joliet, zisofs...)
>    does your disk use?
> d) Mount options?
> 
> This seems to be a rather serious bug, so I'd like to get to the
> bottom with it.

My questions would be: "What hardware?".

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
