Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291611AbSBHPon>; Fri, 8 Feb 2002 10:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291618AbSBHPod>; Fri, 8 Feb 2002 10:44:33 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:18958 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291611AbSBHPoP>;
	Fri, 8 Feb 2002 10:44:15 -0500
Date: Fri, 8 Feb 2002 13:43:44 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <Pine.LNX.4.33.0202081511400.1359-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33L.0202081338480.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Tigran Aivazian wrote:

> It also has a nice extra (/proc/stack) implemented by Hugh Dickins
> which helps to find major offenders.

That's really nice because it gives us the opportunity to
look at the major offenders and see if we can fix those,
instead of bloating up the kernel further.

> Oh btw, please don't tell me "but now you'd need _four_
> physically-contiguous pages to create a task instead of two!" because
> I know it (and think it's not too bad).

On large machines ZONE_NORMAL is in a big squeeze, so
growing a kernel data structure without any justification
is a big no-no.

I take it you've used /proc/stack to find out what the
major offenders are ?

If so, could you share the list of major offenders with us
so we have an idea which functions to fix ?

(I take it you must have run into some problems, otherwise
you wouldn't have posted the patch)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/


