Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRALNhJ>; Fri, 12 Jan 2001 08:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRALNg7>; Fri, 12 Jan 2001 08:36:59 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:37046 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129733AbRALNgs>;
	Fri, 12 Jan 2001 08:36:48 -0500
Message-Id: <m14H4Nl-000OY9C@amadeus.home.nl>
Date: Fri, 12 Jan 2001 14:36:41 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: lmb@suse.de (Lars Marowsky-Bree)
Subject: Re: khttpd beaten by boa
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.LNX.4.21.0101071655090.1110-100000@home.lameter.com> <Pine.LNX.4.21.0101112214040.22231-100000@home.lameter.com> <20010112084259.B441@marowsky-bree.de>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010112084259.B441@marowsky-bree.de> you wrote:
> On 2001-01-11T22:20:56,
>    Christoph Lameter <christoph@lameter.com> said:

>> Then we decided to switch persistant connection off... But boa still wins.
>> 
>> What is wrong here? I would expect transferates of a 3-4 megabytes over a
>> localhost interface. The file is certainly in some kind of cache.

> This just goes on to show that khttpd is unnecessary kernel bloat and can be
> "just as well" handled by a userspace application, minus some rather very
> special cases which do not justify its inclusion into the main kernel.

Well, this test only shows khttpd does badly for localhost, as it doesn't give
userspace a fair chance to schedule. It's too bad Christoph didn't test it 
with the persistent-connections patch that didn't get sent to Linus due to 
the "no more features" freeze (I don't exactly remember which of the freezes
though). 

Regarding wether either khttpd or TuX should be in the kernel: I take it
that it is your oppinion that neither should be in the kernel. I disagree
with that and I think having a http-server-engine  (or even a more generic
file-serving engine) in the kernel can make sense for high-end uses. The
average desktop-user doesn't profit from it, sure. But that also holds for
things like hardware-raid or even SCSI. We still want those in though.

Wether TuX or khttpd should be in... well. I agree with DaveM that TuX is 
certainly the "next and better" generation, and I look forward to working 
with Ingo and others on it. 

Greetings,
 	Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
