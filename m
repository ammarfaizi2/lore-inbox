Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbRDXWRg>; Tue, 24 Apr 2001 18:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132859AbRDXWR3>; Tue, 24 Apr 2001 18:17:29 -0400
Received: from mx.ma.nma.ne.jp ([61.125.128.21]:33192 "HELO mx.ma.nma.ne.jp")
	by vger.kernel.org with SMTP id <S132756AbRDXWQp>;
	Tue, 24 Apr 2001 18:16:45 -0400
Message-ID: <3AE5FB1B.BFF09D8@ma.nma.ne.jp>
Date: Wed, 25 Apr 2001 07:15:55 +0900
From: Masaki Tsuji <jammasa@ma.nma.ne.jp>
X-Mailer: Mozilla 4.75 [ja] (Windows NT 5.0; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Can't read SCSI TAPE
In-Reply-To: <Pine.LNX.3.95.1010424123227.15270A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dears,

"Richard B. Johnson" wrote:
> 
> Hmmm...
> 
> Masaki Tsuji <jammasa@ma.nma.ne.jp>
>                       ^^^^^^^^^^^^ ____ This address
> 
> ... was the address that did the CA-2000-17 attack on one of
> our machines a few weeks ago.
> 
> This is not an accusation, only an observation. You might
> want to tell your network administrator. Sombody at your
> site may be hacking systems.

We're very sorry!

Probabry it's 10th or 11th Apr, isn't it?
I was attacked too, but from outside.

I asked my network administrator about that on 13th Apr, and catched reason.
They said that their network equipments had some probrems, and fixed it.


> SCSI tape problems or your kind are usually caused by a different
> tape compression being used during record and playback. You should
> try to use `mt` to set the compression to something you like
> before you record, and the same compression when you play back
> the tape.

I tried compression option, but It doesn't work well.

I tried ...

No.1
# mt datcompression 1
... write
# mt datcompression 1
... read

No.2
# mt datcompression 0
... write
# mt datcompression 1
... read

No.3
# mt datcompression 1
... write
# mt datcompression 0
... read

No.4
# mt datcompression 0
... write
# mt datcompression 0
... read

, but can't

'datcompression' isn't correct option ?


> You can use `cat` and `od` to read/write from a tape before you
> waste a lot file time with `tar`. You can even do:
> 
>                 ls >/dev/tape
>                  .... takes a lot of time..
> 
>                 cat /dev/tape  # Read back.
> 
> Blocking/deblocking is done in the driver so you can treat it as
> a "slow-to-start" FIFO.

I tried, and got error message...

-----------------------------------
# ls >/dev/tape
st0: Write not multiple of tape block size.   <----- ???
ls: write error: Input/output error
#
-----------------------------------
# cat /dev/tape
[inclemental-] Tue Apr 24 03: ......          <----- looks like good!
#
-----------------------------------

Something wrong?



Thanks, for your help.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Masaki Tsuji
