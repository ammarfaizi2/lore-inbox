Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268540AbTBWTuL>; Sun, 23 Feb 2003 14:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268542AbTBWTuL>; Sun, 23 Feb 2003 14:50:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6406 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268540AbTBWTuK>; Sun, 23 Feb 2003 14:50:10 -0500
Date: Sun, 23 Feb 2003 19:59:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: John Weber <weber@nyc.rr.com>
Subject: Re: 2.5 weirdness
Message-ID: <20030223195940.I20405@flint.arm.linux.org.uk>
References: <20030221221814.GA1316@triplehelix.org> <20030221152502.A9282@sonic.net> <3E592431.3080606@nyc.rr.com> <20030223195200.GA10668@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030223195200.GA10668@triplehelix.org>; from joshk@triplehelix.org on Sun, Feb 23, 2003 at 11:52:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 11:52:00AM -0800, Joshua Kwan wrote:
> On Sun, Feb 23, 2003 at 02:42:41PM -0500, John Weber wrote:
> > The problem is a little stranger than that.  On my system, cardmgr only 
> > "believes" a card is inserted twice if a card is in the pccard slot when 
> >  cardmgr is intially run.  Otherwise, cardmgr and the drivers appear to 
> > function correctly.  Josh, can you try this?
> 
> This was true.
> 
> Dominik's patch which is attached has fixed that for me, at least. This
> applies with some offset to 2.5.62, but it works.

This is his old patch which has issues with cardbus cards.  If you use
this, you also need to add the patch Dominik just posted:

 Date:   Sun, 23 Feb 2003 20:52:07 +0100
 From:   Dominik Brodowski <linux@brodo.de>
 Subject: [PATCH] pcmcia: cs.c bugfix (Russell King)
 Message-ID: <20030223195207.GA3227@brodo.de>

Or just use his second patch in the same thread this patch came from.

 Date: Sun, 23 Feb 2003 13:15:53 +0100
 From: Dominik Brodowski <linux@brodo.de>
 Subject: [UPDATED PATCH] pcmcia: add socket_offset for multiple pci_sockets,
  correct suspend&resume
 Message-ID: <20030223121553.GA10719@brodo.de>

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

