Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271982AbRIDQQn>; Tue, 4 Sep 2001 12:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271985AbRIDQQd>; Tue, 4 Sep 2001 12:16:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:11282 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271982AbRIDQQP>;
	Tue, 4 Sep 2001 12:16:15 -0400
Date: Tue, 4 Sep 2001 13:16:14 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: <linux-kernel@vger.kernel.org>, <marcelo@brutus.conectiva.com.br>
Subject: Re: pmap revisited
In-Reply-To: <200109040313.f843DYc00623@vegae.deep.net>
Message-ID: <Pine.LNX.4.33L.0109041312270.7626-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Samium Gromoff wrote:

>     Gotta wrong results in my previous perftest... (slightly different
>   environments), so these are to be sure that on low VM load there isnt
>   any significant difference...

As expected, the current patch only modifies mechanisms and
leaves most policy the same. Under some loads there is a
difference, but under light VM loads the same-policy-more-info
replacement should indeed be pretty similar.

>   Bonus: two bugs! :)
>    1. Quintela`s (shmtest of memtest) and pmap{2,3} == 100% instant deadlock
>       plain ac12 demonstrates ignorance.

I'll try to reproduce that one when I get back home thursday.

>    2. Swapoff oops 100% - only in pmap3! (okay, swapoff of reiserfs
>       to be strict, but i think that doesnt actually matters)
>       swapoff oops will be in next mail.

This one is fixed. I'll be sitting inside a big tin can with
wings all day tomorrow, but thursday I'll try to post a new
version, hopefully with both these bugs fixed.

Thanks for testing the patch and pointing out the bugs!

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

