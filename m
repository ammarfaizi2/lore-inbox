Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSHPRKb>; Fri, 16 Aug 2002 13:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318602AbSHPRKa>; Fri, 16 Aug 2002 13:10:30 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:46235 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318601AbSHPRK1>; Fri, 16 Aug 2002 13:10:27 -0400
Message-ID: <3D5D32D4.475C6719@wanadoo.fr>
Date: Fri, 16 Aug 2002 19:13:56 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
References: <Pine.LNX.4.44L.0208161340000.1430-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 16 Aug 2002, Jean-Luc Coulon wrote:
> > Rik van Riel wrote:
> > > On Fri, 16 Aug 2002, Jean-Luc Coulon wrote:
> > >
> > > > 2nd while running:
> > > > ------------------
> > > > If I have high disk activity, the system stops responding for a while,
> > > > it does not accepts any key action nor mouse movement. It starts running
> > > > normally after few seconds.
> > >
> > > I've got a patch that might help improve this situation:
> > >
> > > http://surriel.com/patches/2.4/2.4.20-p2ac3-rmap14
> >
> > I've applied the patch, it does not improve the things.
> > The problem seems to be related with a DMA :
> 
> > /dev/hda2:
> > setting using_dma to 1 (on)
> > HDIO_SET_DMA failed: Invalid argument
> > using_dma    =  0 (off)
> 
> Heh indeed.  There's no way to make your system fast if the
> CPU is tied up waiting for the disk all the time ;)
> 
> regards,
> 
> Rik
> --
> Bravely reimplemented by the knights who say "NIH".
> 
> http://www.surriel.com/         http://distro.conectiva.com/

Of course, but I've not yet found the way to setup DMA

At boot time, I get the messages :

Aug 16 11:34:19 f5ibh kernel: ALI15X3: simplex device: DMA disabled
Aug 16 11:34:19 f5ibh kernel: ide0: ALI15X3 Bus-Master DMA disabled
(BIOS)

-----
Regards
	Jean-Luc
