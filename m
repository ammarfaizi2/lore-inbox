Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262323AbRENKta>; Mon, 14 May 2001 06:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbRENKtU>; Mon, 14 May 2001 06:49:20 -0400
Received: from t2.redhat.com ([199.183.24.243]:29168 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262323AbRENKtE>; Mon, 14 May 2001 06:49:04 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15103.18224.265350.877968@pizda.ninka.net> 
In-Reply-To: <15103.18224.265350.877968@pizda.ninka.net>  <200105131759.VAA27768@ms2.inr.ac.ru> <Pine.LNX.4.33.0105132319120.3026-100000@netcore.fi> 
To: "David S. Miller" <davem@redhat.com>
Cc: Pekka Savola <pekkas@netcore.fi>, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org
Subject: Re: IPv6: the same address can be added multiple times 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 May 2001 11:48:53 +0100
Message-ID: <27266.989837333@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>  There is this growing (think growing as in "fungus") set of thinking
> that just because something can be misused, this is an argument
> against it even existing.

> I think this is wrong.  I'm seeing it a lot, especially on this list,
> and it's becomming a real concern at least to me. 

The removal of the perfectly sane get_module_symbol() and replacement with 
a less useful function which looks stuff up in a dynamic table instead of a 
static table built at link time is an example of this. Now I have horrible 
link order dependencies in code which was previously relatively clean. It 
sucks, and there was absolutely no reason for it.

The fact that it was done so late in 2.4-test without even a period of 
marking the original sane version as deprecated made it even worse.

Thinks... if I violently abuse inter_module_crap() will it suffer the same 
fate and can I replace it with get_module_symbol() again? :)

--
dwmw2


