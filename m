Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbRBYESZ>; Sat, 24 Feb 2001 23:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129820AbRBYESP>; Sat, 24 Feb 2001 23:18:15 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:46110 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129817AbRBYER4>; Sat, 24 Feb 2001 23:17:56 -0500
Date: Sat, 24 Feb 2001 23:17:48 -0500 (EST)
From: Jon Eisenstein <jeisen@mindspring.com>
Reply-To: jeisen@mindspring.com
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Odd network problems
In-Reply-To: <3A982B87.3040201@wanadoo.fr>
Message-ID: <Pine.LNX.4.21.0102242313060.30688-100000@dominia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i had a try with Linux-2.4.2 Mozilla 0.8
> > www.codewarrioru.com
> time out answer (pingable however)

Reachable on my windows machine. There may have been some confusion here
-- it is not on a network. The two computers are in different rooms but
share a phone line, regular dial-up modems.
 
> > www.backwire.com
> connection refused with ECN.
> echo '0' > tcp_ecn makes it reachable. Mozilla sucks (CPU99%) and does
> not display the page in a reasonable time (maybe a problem i have with
> java and glibc-2.2.2)

Here are the tcpdumps for two sites. Note that both are complete, with 12
and 8 packets tracked respectively. Normal sites have at least 150 packets
for me.

23:08:44.811245 63.53.132.224.3466 > 64.14.114.71.www: S 964278824:964278824(0) win 2144 <mss 536,sackOK,timestamp 71732491 0,nop,wscale 0> (DF)
23:08:44.976314 64.14.114.71.www > 63.53.132.224.3466: S 89259702:89259702(0) ack 964278825 win 16616 <mss 1460,nop,nop,timestamp 0 0,nop,nop,sackOK> (DF)
23:08:44.976518 63.53.132.224.3466 > 64.14.114.71.www: . ack 1 win 2144 <nop,nop,timestamp 71732508 0> (DF)
23:08:44.984338 63.53.132.224.3466 > 64.14.114.71.www: . 1:501(500) ack 1 win 2144 <nop,nop,timestamp 71732508 0> (DF)
23:08:44.984763 63.53.132.224.3466 > 64.14.114.71.www: P 501:678(177) ack 1 win 2144 <nop,nop,timestamp 71732508 0> (DF)
23:08:45.286316 64.14.114.71.www > 63.53.132.224.3466: . ack 678 win 16616 <nop,nop,timestamp 90878784 71732508> (DF)
23:08:45.426324 64.14.114.71.www > 63.53.132.224.3466: . 1049:1073(24) ack 678 win 16616 <nop,nop,timestamp 90878785 71732508> (DF)
23:08:45.426489 63.53.132.224.3466 > 64.14.114.71.www: . ack 1 win 2144 <nop,nop,timestamp 71732553 90878784,nop,nop,sack sack 1 {1049:1073} > (DF)
23:08:48.646309 64.14.114.71.www > 63.53.132.224.3466: . 525:537(12) ack 678 win 16616 <nop,nop,timestamp 90878817 71732553> (DF)
23:08:48.646482 63.53.132.224.3466 > 64.14.114.71.www: . ack 1 win 2144 <nop,nop,timestamp 71732875 90878784,nop,nop,sack sack 2 {525:537}{1049:1073} > (DF)
23:08:55.206303 64.14.114.71.www > 63.53.132.224.3466: . 525:537(12) ack 678 win 16616 <nop,nop,timestamp 90878883 71732875> (DF)
23:08:55.206484 63.53.132.224.3466 > 64.14.114.71.www: . ack 1 win 2144 <nop,nop,timestamp 71733531 90878784,nop,nop,sack sack 3 {525:537}{525:537}{1049:1073} > (DF)

> > www.counterpane.com
> no problem with this one.

And for this:

23:12:57.726945 63.53.132.224.3479 > 208.42.65.154.www: S 1237658684:1237658684(0) win 2144 <mss 536,sackOK,timestamp 71757783 0,nop,wscale 0> (DF)
23:12:57.976374 208.42.65.154.www > 63.53.132.224.3479: S 3499622070:3499622070(0) ack 1237658685 win 8908 <nop,nop,timestamp 2835260985 71757783,nop,wscale 0,nop,nop,sackOK,mss 536> (DF)
23:12:57.976576 63.53.132.224.3479 > 208.42.65.154.www: . ack 1 win 2144 <nop,nop,timestamp 71757808 2835260985> (DF)
23:12:57.984439 63.53.132.224.3479 > 208.42.65.154.www: . 1:501(500) ack 1 win 2144 <nop,nop,timestamp 71757808 2835260985> (DF)
23:12:57.984854 63.53.132.224.3479 > 208.42.65.154.www: P 501:681(180) ack 1 win 2144 <nop,nop,timestamp 71757808 2835260985> (DF)
23:12:58.336375 208.42.65.154.www > 63.53.132.224.3479: . ack 501 win 8908 <nop,nop,timestamp 2835261021 71757808> (DF)
23:13:03.876409 63.53.132.224.3479 > 208.42.65.154.www: P 501:681(180) ack 1 win 2144 <nop,nop,timestamp 71758398 2835261021> (DF)
23:13:04.166373 208.42.65.154.www > 63.53.132.224.3479: . ack 681 win 8908 <nop,nop,timestamp 2835261605 71757808> (DF)
 
> > www.zip2it.com
> un-resolved (could it be www.zip2.com)

This one was off of the top of my head. Turns out I was referring to
www.zap2it.com, and apparently, that was a one-time problem. That was just
the proverbial straw that broke the camel's back.

----

Jonathan Eisenstein
jeisen@mindspring.com

PGP Public Key: http://www.mindspring.com/~jeisen/pgp.asc

