Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318635AbSHPQkb>; Fri, 16 Aug 2002 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318638AbSHPQka>; Fri, 16 Aug 2002 12:40:30 -0400
Received: from admin.nni.com ([216.107.0.51]:9476 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318635AbSHPQka>;
	Fri, 16 Aug 2002 12:40:30 -0400
Date: Fri, 16 Aug 2002 12:44:15 -0400
From: Andrew Rodland <arodland@noln.com>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
Message-Id: <20020816124415.467e662e.arodland@noln.com>
In-Reply-To: <3D5D287C.F4AE3797@wanadoo.fr>
References: <Pine.LNX.4.44L.0208161036170.1430-100000@imladris.surriel.com>
	<3D5D287C.F4AE3797@wanadoo.fr>
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002 18:29:48 +0200
Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr> wrote:

> Rik van Riel wrote:
> > 
> > On Fri, 16 Aug 2002, Jean-Luc Coulon wrote:
> > 
> > > 2nd while running:
> > > ------------------
> > > If I have high disk activity, the system stops responding for a
> > > while, it does not accepts any key action nor mouse movement. It
> > > starts running normally after few seconds.
> /dev/hda2:
> multcount    =  1 (on)
> IO_support   =  1 (32-bit)
> unmaskirq    =  0 (off)
> using_dma    =  0 (off)
> keepsettings =  0 (off)
> readonly     =  0 (off)
> readahead    =  8 (on)
> geometry     = 3649/255/63, sectors = 29302560, start = 9767520
> HDIO_GET_IDENTITY failed: Invalid argument
> 
> [root@debian-f5ibh] ~ # hdparm -d1 /dev/hda2
> 
> /dev/hda2:
> setting using_dma to 1 (on)
> HDIO_SET_DMA failed: Invalid argument
> using_dma    =  0 (off)
> 
how about umaskirq (hdparm -u1) ? that should help quite a bit, if it
works.

oh, and by the way, does it matter that you're doing hdparm on a
partition rather than the wholedisk?
