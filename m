Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbRGPO7Z>; Mon, 16 Jul 2001 10:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267411AbRGPO7Q>; Mon, 16 Jul 2001 10:59:16 -0400
Received: from adsl-63-199-185-124.dsl.snfc21.pacbell.net ([63.199.185.124]:35184
	"EHLO rvanmete.iprg.nokia.com") by vger.kernel.org with ESMTP
	id <S267400AbRGPO64>; Mon, 16 Jul 2001 10:58:56 -0400
Message-Id: <200107161512.f6GFC6904724@rvanmete.iprg.nokia.com>
To: Jonathan Lundell <jlundell@pobox.com>
cc: rdv@cips.nokia.com, "Justin T. Gibbs" <gibbs@scsiguy.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit scsi read/write 
In-Reply-To: jlundell's message of Sun, 15 Jul 2001 17:37:00 -0700.
	     <p05100322b777ddf1626d@[207.213.214.37]> 
Reply-To: rdv@cips.nokia.com
Date: Mon, 16 Jul 2001 08:11:54 -0700
From: Rod Van Meter <rdv@cips.nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:14 PM -0700 2001-07-15, Rod Van Meter wrote:
> >You can commit an individual write with the FUA (force unit access)
> >bit.  The command for this is not WRITE EXTENDED, but WRITE(10) or
> >WRITE(12).  I don't think WRITE(6) has room for the bit, and WRITE(6)
> >is useless nowadays, anyway.  WRITE EXTENDED lets you write over the
> >ECC bits -- it's a raw write to the platter.  Dunno that anyone
> >implements it any more.
> 
> WRITE EXTENDED is WRITE(10), I believe. The ECC-writing version is 
> WRITE LONG; IBM (at least) implements it.
> 

Whoops, you're right!  Brain fart.  We never used the term WRITE
EXTENDED; we always just called it WRITE(10) or WRITE(12).

	     --Rod
