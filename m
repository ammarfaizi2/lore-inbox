Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUAEAwD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 19:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbUAEAwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 19:52:03 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:16521 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265835AbUAEAv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 19:51:59 -0500
Message-ID: <3FF8B52B.3060003@cyberone.com.au>
Date: Mon, 05 Jan 2004 11:51:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Lincoln Dale <ltd@cisco.com>, Soeren Sonnenburg <kernel@nn7.de>,
       Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au> <20040104120720.GA14497@alpha.home.local>
In-Reply-To: <20040104120720.GA14497@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Willy Tarreau wrote:

>Now testing Con's noint patch against 2.6.0. It returns somewhat simmilar
>results to Nick's w29p2, and behaves normally. The only noticeable difference
>is that a simple task like "while :; do :; done&" eats about 100ms each second,
>so if you start 10 of these, you're able to type only once a second (tested).
>But I understand that this 'dumbness' was exactly the goal of this patch.
>I think that I'll try to use 2.6 + Nick's scheduler for some time on my
>notebook to get an overall idea on how it behaves.
>
>BTW, Nick, does your patch rely on -mm1 exclusive features, or would it be
>possible to back-port it to plain 2.6 ?
>

No, you should be able to port it to 2.6 quite easily if you just apply
the scheduler patches from -mm1 to it first. I'll do a proper release
in the next day or so and include patches for both trees.



