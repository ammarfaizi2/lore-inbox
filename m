Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVENKE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVENKE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVENKDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:03:01 -0400
Received: from innocence-lost.us ([66.93.152.112]:20100 "EHLO
	innocence-lost.net") by vger.kernel.org with ESMTP id S262715AbVENJqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:46:38 -0400
Date: Sat, 14 May 2005 02:46:30 -0700 (MST)
From: jnf <jnf@innocence-lost.us>
To: christos gentsis <christos_gentsis@yahoo.co.uk>
cc: Valdis.Kletnieks@vt.edu, Bill Davidsen <davidsen@tmr.com>,
       linux-os@analogic.com, "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
In-Reply-To: <4285C030.1080706@yahoo.co.uk>
Message-ID: <Pine.LNX.4.62.0505140240250.14650@fhozvffvba.vaabprapr-ybfg.arg>
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
 <200505131522.32403.vda@ilport.com.ua> <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com>
 <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com>           
 <42850FC7.7010603@tmr.com> <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu>
 <4285C030.1080706@yahoo.co.uk>
X-GPG-PUBLIC_KEY: http://innocence-lost.net/jnf-pubkey.asc
X-GPG-FINGRPRINT: E24B 994F D483 12EF 61D4  A384 1F16 EFD1 E1A7 954C
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


firstly lemme say im hardly any authority, so feel free to disregard
anything I have to say, lord knows everyone else does.

I would say that this is more or less a known issue, and not really an
issue- at least not as far as I can see- I would hope that by 2038 64b (or
larger) int's would be standard.

> but shall i ask how
> counting something that increase can give a negative number?

what would you expect MAX_INT+1 to yield?
as a short example:

submission$ cat test.c
int main(void) {
        signed short int count = 0;

        while(count >= 0 ) {
                printf("count: %d\n", count++ );
        }
        printf("count: %d\n");
}
submission$ gcc -o test test.c
submission$ ./test
[...]
count: 32767
count: -1


> second... is the counter on the software? until now i thought that the counter
> is a clock on the hardware...

IIRC the software keeps track of the count, so even though its physically
a hardware clock, the software still has to count it- if a 32b int can
only represent 2^32-1, then we will hit a wall, for our purposes this will
be in 2038, unless by then linux switches to a 64b counter, which is quite
probably (and possibly already done under amd64 and the likes?)

> so how is this related with Linux? then the
> counter overflow... this will be a hardware issue... not a software issue (
> the software will have to support the bigger hardware counter but to do that
> the bigger hardware has to exist first...)

I could be wrong here, but I don't think the hardware even keeps track of
the clock ticks, rather it just ticks and lets the software keep track.

> BTW is there anyone that plan to use his embedded devise until 2038????

not exactly an embedded device however I have my feet resting on an ibm
ps/2 286 running minix. Some people hold onto things longer than other
people.

