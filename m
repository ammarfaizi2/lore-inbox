Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293654AbSB1Sa6>; Thu, 28 Feb 2002 13:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293647AbSB1S2F>; Thu, 28 Feb 2002 13:28:05 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:57846 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293648AbSB1S1B>; Thu, 28 Feb 2002 13:27:01 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0202280854250.15607-100000@home.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0202280854250.15607-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Feb 2002 18:26:58 +0000
Message-ID: <365.1014920818@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  Not a chance in hell. The backwards compatibility looks like a
> trivial one-liner:

>    compat-2.4.h:
> 	#define recalc_sigpending() recalc_sigpending(current)

> so what are you complaining about? 

Fine. I was trying to define a back-compat version of recalc_sigpending_tsk()
too, before going through all the code and changing recalc_sigpending(current)
to recalc_sigpending and recalc_sigpending(other) to recalc_sigpending_tsk() 
- but as you rightly point out there's no justification for using the latter
in any of the driver or fs code that I'm trying to support - and hence it
isn't present, and doesn't need the compat support.


--
dwmw2


