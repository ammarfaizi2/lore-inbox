Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbTBUGw4>; Fri, 21 Feb 2003 01:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbTBUGw4>; Fri, 21 Feb 2003 01:52:56 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35336
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267183AbTBUGwz>; Fri, 21 Feb 2003 01:52:55 -0500
Date: Thu, 20 Feb 2003 23:01:58 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: part fix the highpoint timing/overclock bug
In-Reply-To: <1045753988.3790.8.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10302202259350.15361-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2003, Alan Cox wrote:

> On Thu, 2003-02-20 at 04:18, Andre Hedrick wrote:
> > That will deadlock it into a death spiral beause PIO is not setup either,
> > but I like the warning!
> 
> Should be ok. It'll fail to allow DMA modes so will retune the drive unless
> Im missing something
> 

Recent discoveries showed if one does not tune the basics for pio, it goes
into a lost interrupt spin.  It will run, but each IO suffers 4/5
interrupts lost.  It can take up to 4 hours to boot in some cases.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

