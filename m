Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318614AbSHPQhA>; Fri, 16 Aug 2002 12:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318622AbSHPQhA>; Fri, 16 Aug 2002 12:37:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:34067 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318614AbSHPQg7>; Fri, 16 Aug 2002 12:36:59 -0400
Date: Fri, 16 Aug 2002 13:40:44 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
In-Reply-To: <3D5D287C.F4AE3797@wanadoo.fr>
Message-ID: <Pine.LNX.4.44L.0208161340000.1430-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, Jean-Luc Coulon wrote:
> Rik van Riel wrote:
> > On Fri, 16 Aug 2002, Jean-Luc Coulon wrote:
> >
> > > 2nd while running:
> > > ------------------
> > > If I have high disk activity, the system stops responding for a while,
> > > it does not accepts any key action nor mouse movement. It starts running
> > > normally after few seconds.
> >
> > I've got a patch that might help improve this situation:
> >
> > http://surriel.com/patches/2.4/2.4.20-p2ac3-rmap14
>
> I've applied the patch, it does not improve the things.
> The problem seems to be related with a DMA :

> /dev/hda2:
> setting using_dma to 1 (on)
> HDIO_SET_DMA failed: Invalid argument
> using_dma    =  0 (off)

Heh indeed.  There's no way to make your system fast if the
CPU is tied up waiting for the disk all the time ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

