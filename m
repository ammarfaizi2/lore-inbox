Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274585AbRITRzi>; Thu, 20 Sep 2001 13:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274586AbRITRz1>; Thu, 20 Sep 2001 13:55:27 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:38051 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S274585AbRITRzU>; Thu, 20 Sep 2001 13:55:20 -0400
Message-ID: <3BAA2D7F.DBBCFC8C@pp.inet.fi>
Date: Thu, 20 Sep 2001 20:55:11 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "steve j. kondik" <shade@chemlab.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
In-Reply-To: <1000912739.17522.2.camel@discord>
			<3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de>
			<3BA9DC30.DA46A008@pp.inet.fi>  <20010920142555.B588@suse.de>
			<1000991848.569.1.camel@discord>  <3BAA21B1.B579D368@pp.inet.fi> <1001006425.1498.9.camel@discord>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"steve j. kondik" wrote:
> hmm?  both cryptoapi and loop-aes work just fine when encrypting
> anything but swap.  this is _only_ with kernel 2.4.10-pre12.  i would
> suspect something changed that breaks swap on loopdev in general in this
> kernel.

loop-AES encrypted swap works just fine on 2.4.10-pre12, see:

# uname -a
Linux debian 2.4.10-pre12 #1 Thu Sep 20 20:15:08 EEST 2001 i686 unknown
# vmstat 
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  1   4708   2708   1824  12856  19  28   682   623  223   119   5  74  21
# swapon -s
Filename                        Type            Size    Used    Priority
/dev/loop6                      partition       191512  4704    -1
# losetup /dev/loop6
/dev/loop6: [0301]:170184 (/dev/hda2) offset 0, AES encryption

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

