Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbTCNNg6>; Fri, 14 Mar 2003 08:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263348AbTCNNg6>; Fri, 14 Mar 2003 08:36:58 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:36775 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S263346AbTCNNg4>;
	Fri, 14 Mar 2003 08:36:56 -0500
Date: Fri, 14 Mar 2003 16:43:28 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Joern Engel <joern@wohnheim.fh-wedel.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, vda@port.imtp.ilyichevsk.odessa.ua,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       deanna_bonds@adaptec.com
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
Message-ID: <20030314134328.GA8804@linuxhacker.ru>
References: <20030313182819.GA2213@linuxhacker.ru> <20030313105125.1548d67c.rddunlap@osdl.org> <20030313185628.GA2485@linuxhacker.ru> <200303140921.h2E9Lqu08107@Port.imtp.ilyichevsk.odessa.ua> <1047651597.27700.1.camel@irongate.swansea.linux.org.uk> <20030314133942.GA23062@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314133942.GA23062@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 14, 2003 at 02:39:42PM +0100, Joern Engel wrote:
> > > Can we just add a 4 byte scratch pad status to
> > > struct _adpt_hba? Let it scribble there...
> > Its 4 bytes (+ slab overhead), its far safer if this happens to say
> > its gone forever. Its owned by the I2O controller now and it never
> > gave it back
> How about an (optional) counter then? If you can show that this case
> is hit zero times during operation, noone will complain. On the other
> hand, if some hardware hits this problem 1000+ times, we have a good
> reason to find another solution.
> I'd volunteer to create the patch, if the idea is accepted.

Well, if some hardware would do so, then users would go here and complain
about kernel being noisy on certain hardware. (message is printed each
time this happens). Have not happened so far.

Bye,
    Oleg
