Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272590AbRITGQL>; Thu, 20 Sep 2001 02:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274324AbRITGQA>; Thu, 20 Sep 2001 02:16:00 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:17669 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S272590AbRITGPz>; Thu, 20 Sep 2001 02:15:55 -0400
Date: Thu, 20 Sep 2001 08:13:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: "steve j. kondik" <shade@chemlab.org>, linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
Message-ID: <20010920081353.H588@suse.de>
In-Reply-To: <1000912739.17522.2.camel@discord> <3BA907F6.3586811C@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA907F6.3586811C@pp.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20 2001, Jari Ruusu wrote:
> "steve j. kondik" wrote:
> > i've been using encrypted swap over loopdev using the new cryptoapi
> > patches.  i just built a 2.4.10-pre12 kernel and i got a panic doing
> > mkswap on the loopdev.  the mkswap process becomes unkillable after this
> > and never finishes.  this is repeatable everytime.  i've had no problems
> > whatsoever until this kernel even under high load..  any ideas? :>
> 
> Cryptoapi can't be used to encrypt swap. It has nasties like sleeping in
> make_request_fn() and potential memory allocation deadlock.

sleeping in make_request_fn is not a nasty in itself, btw. in fact loop
just needs an emergency page pool for swap to be perfectly safe.

-- 
Jens Axboe

