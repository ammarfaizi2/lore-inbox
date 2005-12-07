Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVLGH5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVLGH5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 02:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVLGH5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 02:57:21 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:51146 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S1750701AbVLGH5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 02:57:21 -0500
Date: Wed, 7 Dec 2005 08:56:29 +0100 (CET)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub5.ifh.de
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Michael Krufky <mkrufky@gmail.com>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Prakash Punnoor <prakash@punnoor.de>
Subject: Re: [linux-dvb-maintainer] Re: [PATCH] b2c2: make front-ends   
 selectable and include noob option
In-Reply-To: <20051207002919.GA18629@linuxtv.org>
Message-ID: <Pine.LNX.4.64.0512070849300.18120@pub5.ifh.de>
References: <200512062053.00711.prakash@punnoor.de>    
 <37219a840512061220w17388551jd54c189973e23355@mail.gmail.com>    
 <200512062139.16846.prakash@punnoor.de>     <20051206215610.GA18247@linuxtv.org>
     <37219a840512061420j6dc6a0bdy71cc817706dcd0ef@mail.gmail.com>
 <20051207002919.GA18629@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2005, Johannes Stezenbach wrote:
> I think b2c2-flexcop-pci uses a 240K dma buffer, whether you
> save a few K in demodulator code doesn't mean much.
> The saved memory will be similarly unnoticable to the user as
> if you would go and scatter #ifdefs all over tuner-simple.c.
>
> But I'm neither the author nor the maintainer of the b2c2-flexcop
> driver, you better ask Patrick if he likes it.

There will be at least two new devices in the future, which again will 
need (at least) two new demod(and maybe tuner)-modules.

Prakash, if it is just the i2c_xfer failed, that could be easily turned 
into a debug-message, but I rather have these as errors, because they are.

I don't see the need for the ifdef - on the contrary: the number of people 
asking for which demod they shall load dropped significantly after 
FE_REFACTORING starting one year ago - now reintroducing that again is not 
a good idea, IMO.

best regards,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
