Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUKWOFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUKWOFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbUKWOEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:04:13 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:14092 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261201AbUKWOCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:02:05 -0500
Message-ID: <29024.195.245.190.94.1101218441.squirrel@195.245.190.94>
In-Reply-To: <20041123135508.GA13786@elte.hu>
References: <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
    <20041122020741.5d69f8bf@mango.fruits.de>
    <20041122094602.GA6817@elte.hu>
    <56781.195.245.190.93.1101119801.squirrel@195.245.190.93>
    <20041122132459.GB19577@elte.hu>
    <20041122142744.0a29aceb@mango.fruits.de>
    <65529.195.245.190.94.1101133129.squirrel@195.245.190.94>
    <20041122154516.GC2036@elte.hu>
    <9182.195.245.190.93.1101142412.squirrel@195.245.190.93>
    <20041123135508.GA13786@elte.hu>
Date: Tue, 23 Nov 2004 14:00:41 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Florian Schmidt" <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041123140041_52308"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Nov 2004 14:02:02.0722 (UTC) FILETIME=[01E9D420:01C4D165]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041123140041_52308
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
>
> the max CPU load i get here is 46% (your laptop is faster), but no
> xruns. The result of a 5-minute run is:
>
>  ************* SUMMARY RESULT ****************
>  Timeout Count . . . . . . . . :(    0)
>  XRUN Count  . . . . . . . . . :     0
>  Delay Count (>spare time) . . :     0
>  Delay Count (>1000 usecs) . . :     0
>  Delay Maximum . . . . . . . . :     0   usecs
>  Cycle Maximum . . . . . . . . :  1016   usecs
>  Average DSP Load. . . . . . . :    46.4 %
>  Average CPU System Load . . . :    40.5 %
>  Average CPU User Load . . . . :     2.3 %
>  Average CPU Nice Load . . . . :     0.0 %
>  Average CPU I/O Wait Load . . :     0.0 %
>  Average CPU IRQ Load  . . . . :     0.0 %
>  Average CPU Soft-IRQ Load . . :     0.0 %
>  Average Interrupt Rate  . . . :  2374.1 /sec
>  Average Context-Switch Rate . : 19172.8 /sec
>
> i suspect i need to activate some option/define in jackd to get some of
> the more advanced stats such as delay-maximum?
>

Yes, there's a non-official patch to jackd from Lee Revell's. Without that
you don't get to read the maximum delay from jackd. Sorry. But if you have
the patience to rebuild jack, here comes attached the minimal patch for
just that.

Seeya.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20041123140041_52308
Content-Type: application/x-gzip-compressed;
      name="jack-0.99.10-max_delayed_usecs.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="jack-0.99.10-max_delayed_usecs.patch.gz"

H4sICJVthUEAA2phY2stMC45OS4xMC1tYXhfZGVsYXllZF91c2Vjcy5wYXRjaAC9Vm1vo0YQ/mx+
xeikSkmwMZDY2I4uyrW6k9qe7qpc3z5UQmsYYBu8oGXJS0/33zu7i2Mb20rSD+ULsDvP7Mwzb5vy
LINR2v7yScLfLLn1/LF+jblQKAUrvcIuB/1lZzQaHUEMQt+/GAX+KJiAP1lczBfBzPPXD7h+4PuO
67pHND/BzwMIw8VkuvCnnj+PomkUhTOC0+NcX8MoCKbDKbj6FcH1tQP6IT3nYawGA4CCNXHCarbk
JVccm0srkZUVU9B/krqNaSPdFtJKHmQr4hRL9ohp3DaYkBp3R2LFHvoCRkW7ZUpdSRWT4OWekShy
LjCubrstTUZsxNVjjTFPSQxAbJZIfXokaOZ7N2B2aS9YdvmJaaJVB8pfhBfPBqoH3Q3SjII0iaZb
QYouTJD0KwxMlCz/xs816XBif0uOgryEM/t1Spw4MD4704yfwbVE1UoBqkBNOl+1KzDEg0RND6aw
fDS7S9KGIoWGiwTBohvFpGprqCSJN6g8gD8KFJBUq5pJwqrKYGuUvNLQf5DiBCaiQ9rhTacoYQKW
qDcMBhvFV0yhAfMUWbmjIqPzGOT8jo6iU9vaM1rGjrvFQ44mO3bT6DgpruM+kXKjfTlASVK1uqLI
y1+16fdVW6ad2Vlbdq70zccsw0RrI8MYJAUTOa55SSqR8byVTPFKQJWRAJWG4CJfE/zYKFzBCXq5
R6A8L/XeLVU1EiUScVVr6KmuS6hsGK2tFo8PmjekiJk4/vTuh5+HcM9VUbWKMHdaG9lCwdORNHAt
01XQE613FU8tqybM/4FXbcyXjtSUS2Kkko86F+4LnhRmuUF5hxKIWG11QqnndHySoZRDZDFXjc6t
VSt4Yjn78OOHz40H78AeaBD3vCxBoE2lhNGPybQlUt6gWSC3jxV8Ou58T7YrdLPaL/vNzqbyfQjO
FwFV/rMt+gB6u/gJQcUfRuFW8YfBxFS/edsePbBKRleUT0pW5egqrWIiqaySW3gL9GO/Lw+JPvWL
t+AfFNjv1lbU3RfdzwurFA7pXbZUGTI2Fd2dbZJISSYa05q54Ipy3wAplYz3YRQZ78NoNpwb719s
c3+gkAc8g5NdsSt43qtTQr7M+f6Q07ZS11Kenjq0/+dNK0xDtq7rIMW5ZHXRd/tiPjduT/zz4Wzt
tsF0w66uGhXXskqwabbAnRD17DiTbIUxdSZc7w9BmMVG1+n/zQUMaPR0gddj2qbowro7mYfW3fls
4+7v72++//zl/cb6NyVrlLlNWOUL+M47z+x4+Uu8GRLmJalhvN9XTj4cGIXdGNw76kUs2OE7GJ9B
Rr27Yxc6eWiKFTXBfEX5obvuXloTWZ9++/jx4F2l5Etzk7BtcNO8+uvb7au/99qry1H8bgsLqIUF
ob99yZz79pap34GN76C7iFhlo6u174fuivBNF6+Z9Y77+mHvuF8pXEfOO3DzdL/pKaZnYHfaK4eg
Pe/Zgyi84Ht+1h0ItSokMrqrOrCj167yoxc8B746/wIC6XTagwwAAA==
------=_20041123140041_52308--


