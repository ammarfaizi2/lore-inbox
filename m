Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281836AbRLWNWf>; Sun, 23 Dec 2001 08:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282379AbRLWNWZ>; Sun, 23 Dec 2001 08:22:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63758 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281836AbRLWNWN>; Sun, 23 Dec 2001 08:22:13 -0500
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
To: andre@linux-ide.org (Andre Hedrick)
Date: Sun, 23 Dec 2001 13:31:35 +0000 (GMT)
Cc: stodden@in.tum.de (Daniel Stodden), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112222312030.8976-100000@master.linux-ide.org> from "Andre Hedrick" at Dec 22, 2001 11:24:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16I8j1-0000ah-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am just waiting to rip somebody's lunch who disagrees with me on the
> importance of data-recovery and relocation upon media failures.  Any
> points claiming it is not important because the predictive nature of
> device failure is unknown, should maybe ask an expert in the industry to
> get you the answer.  So lets have some fun and light off a really good
> flame war!

Why do you want to pass it up to the file system, when the fs probably
doesn't know what to do about it ? I can see why you want to pass it back
as far up as you can until someone claims it.

Or are you assuming in most cases file systems would have an "io_failure"
function that reissues the request a few times then marks the fs read only
and screams ?

Incidentally the EVMS IBM volume manager code does support bad block
remapping in some situations.

Alan
