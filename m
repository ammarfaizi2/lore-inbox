Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUBPDWW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUBPDWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:22:21 -0500
Received: from [80.72.36.106] ([80.72.36.106]:22727 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S265319AbUBPDWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:22:20 -0500
Date: Mon, 16 Feb 2004 04:22:15 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop	device?)
 on 2.6.*)
In-Reply-To: <1076900606.5601.47.camel@leto.cs.pocnet.net>
Message-ID: <Pine.LNX.4.58.0402160409190.26082@alpha.polcom.net>
References: <402A4B52.1080800@centrum.cz>  <1076866470.20140.13.camel@leto.cs.pocnet.net>
  <20040215180226.A8426@infradead.org>  <1076870572.20140.16.camel@leto.cs.pocnet.net>
  <20040215185331.A8719@infradead.org>  <1076873760.21477.8.camel@leto.cs.pocnet.net>
  <20040215194633.A8948@infradead.org>  <20040216014433.GA5430@leto.cs.pocnet.net>
  <20040215175337.5d7a06c9.akpm@osdl.org>  <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net>
 <1076900606.5601.47.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your fast response!

On Mon, 16 Feb 2004, Christophe Saout wrote:

> Am Mo, den 16.02.2004 schrieb Grzegorz Kulewski um 03:07:
> 
> > > Is there more documentation that this?  I'd imagine a lot of crypto-loop
> > > users wouldn't have a clue how to get started on dm-crypt, especially if
> > > they have not used device mapper before.
> > > 
> > > And how do they migrate existing encrypted filesytems?
> > 
> > And is the format considered "stable"?
> > (= if I will create fs on it, will I have problems with future kernels?)
> 
> Yes. The cryptoloop compatible format will stay this way. The format
> (basically the cipher used and the iv generation mode) can be specified.
> 
> I posted a small description some time ago:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105967481007242&w=2
> 
> The -cbc was renamed to -plain in order to make more iv generation
> methods possible which of course also use the CBC mode.

Did you heard / read about Herring?
I found .pdf somewhere (I think I still have it). It is better alternative 
to ECB or CBC algorithms used in cryptoloop (if I understand good). Could 
something like that be implemented in dm-crypt? Is it already?

Could somebody write dm-compress (compressing not encrypting)? Is it 
technically possible (can device mapper handle different data size at 
input, differet at output)? (I think there is compressing loop patch.)
Could dm first compress data (even with weak algorithm), then encrypt, to 
make statistical analysis harder?

And, to be sure, does dm-crypto add anything in the begining (ie. 
header) or in other places to the stored data? Or it is the same data 
(same size) but encrypted?  


Grzegorz Kulewski

