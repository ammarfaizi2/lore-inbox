Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271839AbRH2Ntf>; Wed, 29 Aug 2001 09:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271889AbRH2NtQ>; Wed, 29 Aug 2001 09:49:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:33540 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271839AbRH2NtE>;
	Wed, 29 Aug 2001 09:49:04 -0400
Date: Wed, 29 Aug 2001 10:48:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <oup8zg4j8u0.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.LNX.4.33L.0108291047060.27250-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2001, Andi Kleen wrote:

> Regarding kswapd in 2.4.9:
>
> At least something seems to be broken in it. I did run some 900MB processes
> on a 512MB machine with 2.4.9 and kswapd took between 70 and 90% of the CPU
> time.

Well yes, if you never wait on IO synchronously kswapd turns
into one big busy-loop. But we knew that, it was even written
down in the comments in vmscan.c ;)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/ http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

