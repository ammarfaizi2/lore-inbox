Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSKUUeV>; Thu, 21 Nov 2002 15:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSKUUeV>; Thu, 21 Nov 2002 15:34:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8979 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264733AbSKUUeU>; Thu, 21 Nov 2002 15:34:20 -0500
Date: Thu, 21 Nov 2002 15:40:16 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: "Filipau, Ihar" <ifilipau@sussdd.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: useless image of hdd: how to make it useful?
In-Reply-To: <20021118215158.GA2183@win.tue.nl>
Message-ID: <Pine.LNX.3.96.1021121153759.10456B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Andries Brouwer wrote:

>    Device Boot    Start       End   #sectors  Id  System
>  hdc_img1            63    112454     112392  83  Linux
>  hdc_img2        112455    401624     289170  82  Linux swap
>  hdc_img3        401625  33736499   33334875   5  Extended
>  ...
> 
> OK, let us mount this first one, at an offset of 63 sectors.
> 
> % bc
> 63*512
> 32256
> 
> # mount hdc_img /mnt -o loop,offset=32256
> #

Being at heart a lazy fellow, and not counting on people to have bc
installed although they should...
  # mount hdc_img /mnt -o loop,offset=$[63*512]

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

