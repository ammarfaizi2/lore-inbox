Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274615AbRITTAJ>; Thu, 20 Sep 2001 15:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274618AbRITTAG>; Thu, 20 Sep 2001 15:00:06 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:15519 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S274612AbRITS7h>; Thu, 20 Sep 2001 14:59:37 -0400
Date: Thu, 20 Sep 2001 14:59:50 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: "steve j. kondik" <shade@chemlab.org>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
Message-ID: <20010920145950.I16647@alcove.wittsend.com>
Mail-Followup-To: Jari Ruusu <jari.ruusu@pp.inet.fi>,
	"steve j. kondik" <shade@chemlab.org>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1000912739.17522.2.camel@discord> <3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de> <3BA9DC30.DA46A008@pp.inet.fi> <20010920142555.B588@suse.de> <1000991848.569.1.camel@discord> <3BAA21B1.B579D368@pp.inet.fi> <1001006425.1498.9.camel@discord> <3BAA2D7F.DBBCFC8C@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAA2D7F.DBBCFC8C@pp.inet.fi>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 08:55:11PM +0300, Jari Ruusu wrote:
> "steve j. kondik" wrote:
> > hmm?  both cryptoapi and loop-aes work just fine when encrypting
> > anything but swap.  this is _only_ with kernel 2.4.10-pre12.  i would
> > suspect something changed that breaks swap on loopdev in general in this
> > kernel.

> loop-AES encrypted swap works just fine on 2.4.10-pre12, see:

	But that's only your system.  He obvious has a counter example
(which may not be the fault of loop-AES, but something else, that has
yet to be determined).  So the two of you are now reduced to figuring
out why his is broken as yours is not.  Standard debugging situation.

> # uname -a
> Linux debian 2.4.10-pre12 #1 Thu Sep 20 20:15:08 EEST 2001 i686 unknown
> # vmstat 
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  0  1   4708   2708   1824  12856  19  28   682   623  223   119   5  74  21
> # swapon -s
> Filename                        Type            Size    Used    Priority
> /dev/loop6                      partition       191512  4704    -1
> # losetup /dev/loop6
> /dev/loop6: [0301]:170184 (/dev/hda2) offset 0, AES encryption

> Regards,
> Jari Ruusu <jari.ruusu@pp.inet.fi>

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

