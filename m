Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263327AbTCNN30>; Fri, 14 Mar 2003 08:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263328AbTCNN30>; Fri, 14 Mar 2003 08:29:26 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:9611 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263327AbTCNN3X>; Fri, 14 Mar 2003 08:29:23 -0500
Date: Fri, 14 Mar 2003 14:39:42 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Oleg Drokin <green@linuxhacker.ru>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       deanna_bonds@adaptec.com
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
Message-ID: <20030314133942.GA23062@wohnheim.fh-wedel.de>
References: <20030313182819.GA2213@linuxhacker.ru> <20030313105125.1548d67c.rddunlap@osdl.org> <20030313185628.GA2485@linuxhacker.ru> <200303140921.h2E9Lqu08107@Port.imtp.ilyichevsk.odessa.ua> <1047651597.27700.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1047651597.27700.1.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 March 2003 14:19:58 +0000, Alan Cox wrote:
> On Fri, 2003-03-14 at 09:18, Denis Vlasenko wrote:
> > I don't like the whole idea that mem leak is tolerable.
> > 
> > Can we just add a 4 byte scratch pad status to
> > struct _adpt_hba? Let it scribble there...
> 
> Its 4 bytes (+ slab overhead), its far safer if this happens to say
> its gone forever. Its owned by the I2O controller now and it never
> gave it back

How about an (optional) counter then? If you can show that this case
is hit zero times during operation, noone will complain. On the other
hand, if some hardware hits this problem 1000+ times, we have a good
reason to find another solution.

I'd volunteer to create the patch, if the idea is accepted.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
