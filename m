Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSEXCRd>; Thu, 23 May 2002 22:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317071AbSEXCRc>; Thu, 23 May 2002 22:17:32 -0400
Received: from ip68-6-164-6.sd.sd.cox.net ([68.6.164.6]:23442 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP
	id <S314080AbSEXCRb>; Thu, 23 May 2002 22:17:31 -0400
Date: Thu, 23 May 2002 19:17:28 -0700
From: Marc Wilson <msw@cox.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Cannot write a 90' cd
Message-ID: <20020524021728.GA1058@moonkingdom.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3CED69EB.2060003@zaralinux.com> <20020524005754.I27005@ucw.cz> <3CED7A65.7010004@zaralinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 01:25:25AM +0200, Jorge Nerin wrote:
> Vojtech Pavlik wrote:
> >
> >90 minute CD-Rs have a tighter leading track, and only some CD-R drives
> >are able to cope with that. For example my Ricoh doesn't, failing some
> >54 minutes after start. There is nothing you can do about that.
> >
> 
> It could be that, but I suspect something strange, the cd reports itself to 
> be about 80', then cdrecord is unable to write past this 80', after 
> cdrecord fixates the cd and ejects it I can see that there is still a 
> virgin zone of about 5 milimeters at the edge of the disk.

Not all drives have firmware that does good support for overburning.  My
NEC 7700A will never burn beyond the encoded time in the ATIP, no matter
what you do.  I wasted several 90 min discs before I figured this out.

It has an artificial block. :)

> Input/output error. write_g1: scsi sendcmd: no error
> CDB:  2A 00 00 05 7D 89 00 00 1F 00
> status: 0x2 (CHECK CONDITION)
> Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 63 00 00 00
> Sense Key: 0x5 Illegal Request, Segment 0
> Sense Code: 0x63 Qual 0x00 (end of user area encountered on this track) Fru 
> 0x0
> Sense flags: Blk 0 (not valid)
> cmd finished after 0.004s timeout 40s

Yep, that's what I used to see before I stopped trying to do it with THAT
drive. :)

-- 
Marc Wilson
msw@cox.net

