Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292555AbSCSU17>; Tue, 19 Mar 2002 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSCSU1k>; Tue, 19 Mar 2002 15:27:40 -0500
Received: from bnathan.remote.ics.uci.edu ([128.195.36.177]:15347 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S292555AbSCSU1c>; Tue, 19 Mar 2002 15:27:32 -0500
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP
To: m.knoblauch@teraport.de
Date: Tue, 19 Mar 2002 12:27:58 -0800 (PST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <no.id> from "Martin Knoblauch" at Mar 19, 2002 07:42:04 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020319202758.1500989548@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
>Mar 19 00:36:41 fems146 xfs: xfs startuP succeeded
>Mar 19 00:36:41 fems146 xfs: listening on port 7100 
>Mar 19 00:36:41 fems146 xfs: ieNoring font path element /usr/X11R6/lib/X11/fonts/100dpi:unscaled (unreadable) 
>Mar 19 00:36:41 fems146 anacron: anacron startup succeeded
>Mar 19 00:36:41 fems146 xfs: ignoring font path elemeNt /usr/X11R6/lib/X11/fonts/CID (unreadable) 
>Mar 19 00:36:41 fems146 xfs: ignoring font path elEment /usr/X11R6/lib/X11/fonts/local (unreadable) 
>Mar 19 00:36:41 fems146 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/japanese (unreadable) 
>Mar 19 00:36:41 fems146 atd: atd stapTup succeeded
>Mar 19 00:36:42 fems146 rc: Starting dont_blank:  succeeded
>Mar 19 00:36:42 fems14 hdaset: 
>Mar 19 00:36:42 fems146 hdaset: /dev/hda:
>Mar 19 00:36:42 fems146 hdaset:  setting usIng_dma to 1 (on)
>Mar 19 00:36:42 fems146 hdaset:  using_dma    =  1 (on)
>Mar 19 00:36:42 fems14 rc: Starting hdaset:  succeeded
[snip]

Looking at it on a byte-by-byte level, it looks like (at least) these
types of bit flips are happening:

     --1-----
     --0-----
     ------0-
MSB->76543210<-LSB

That is, it looks like sometimes bit 5 is being flipped on or off, or bit
1 is being flipped off. (There could be others that I just haven't seen in
those logs yet.) I'm suspecting bad hardware (in case that wasn't
obvious), but I don't know exactly what component is defective. (By the
way, the BIOS has ECC error correction enabled, right??)

Also, do the weird capitalization changes in the logs happen on screen
too, or only in the logfile?

-Barry K. Nathan <barryn@pobox.com>
