Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314855AbSD2Hhx>; Mon, 29 Apr 2002 03:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314857AbSD2Hhw>; Mon, 29 Apr 2002 03:37:52 -0400
Received: from 90dyn126.com21.casema.net ([62.234.21.126]:31672 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S314855AbSD2Hhw>; Mon, 29 Apr 2002 03:37:52 -0400
Message-Id: <200204290737.JAA17086@cave.bitwizard.nl>
Subject: Re: linux-2.5.x-dj and SCSI error handling.
In-Reply-To: <UTC200204271630.g3RGUgF04840.aeb@smtp.cwi.nl> from "Andries.Brouwer@cwi.nl"
 at "Apr 27, 2002 06:30:42 pm"
To: Andries.Brouwer@cwi.nl
Date: Mon, 29 Apr 2002 09:37:49 +0200 (MEST)
CC: davej@suse.de, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> > The recent patch from Christoph Hellwig which kills off
> > the last remaining remnants of the old style SCSI error handling.
> > ...
> 
> Is the new scsi-eh generally regarded as a good thing?

Oh, and if someone is working in the area of "error handling", please,
please allow me to turn off "retries". That's not going to cost much
in terms of code or performance, but increadably valuable for me: We
do datarecovery. So we regularly have "bad" disks in here, and when
the drive reports an error on block <N> we would much rather have the
drive try block <N+1> than have the OS retry block <N>. (Chances of
block <N> getting results is lower than about 5% (given that the drive
has reported an error for that block), while in general the chances of
a random block getting recovered is better than 99%)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
