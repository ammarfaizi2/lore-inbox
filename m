Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283836AbRLITdq>; Sun, 9 Dec 2001 14:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283860AbRLITdg>; Sun, 9 Dec 2001 14:33:36 -0500
Received: from [194.234.65.222] ([194.234.65.222]:58772 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S283836AbRLITdW>; Sun, 9 Dec 2001 14:33:22 -0500
Date: Sun, 9 Dec 2001 20:32:57 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Chris Friesen <chris_friesen@sympatico.ca>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: software raid issues -- possible kernel I/O problem?
In-Reply-To: <3C11358D.28400117@sympatico.ca>
Message-ID: <Pine.LNX.4.30.0112092025260.31840-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <snip />
> So, my observations are as follows:
>
> 1) It seems as though I can't get aggregate burst speeds up above about
> 100MB/s no matter what I do, even when it's on separate interfaces with
> separate IRQs.  Is this running into the limitation of the PCI bus?  I'm
> also somewhat confused as to how my old ata33 drive managed to score
> nearly 100MB/s burst speed, as well as how some people are claiming
> scores of 160MB/s on a ata100 drive (and why I'm not getting that on
> mine).

The 100MB/s is probably the PCI bus, yes. The theoretical limit of a
32bit,33MHz PCI bus is 33^6*32/8 = 132.000.000 = ~ 125MB/s. In practice,
there's always some overhead.

An ATA33 drive can't go over 33MB/s, as the bus don't deliver any more.
an ATA100 bus can give you 100MB/s, but there is currently no drive
available that can give you that. The fastest drive I've read about, is
the Western Digital WD1200BB (120 gig). They brag about pushing 525Mbit/s
from buffer to disk. That's some 65 megs per sec, which is pretty amazing.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

