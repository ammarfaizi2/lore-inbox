Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270381AbRIFLVi>; Thu, 6 Sep 2001 07:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270347AbRIFLV2>; Thu, 6 Sep 2001 07:21:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:17169 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270381AbRIFLVN>;
	Thu, 6 Sep 2001 07:21:13 -0400
Date: Thu, 6 Sep 2001 08:21:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904164306.A1387@cs.cmu.edu>
Message-ID: <Pine.LNX.4.33L.0109060819270.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Jan Harkes wrote:

> The pte_chain allocation stuff looks a bit scary, where did you want
> to reclaim them from when memory runs out, unmap existing pte's?

Exactly. This is the strategy also used by BSD and it seems to
work really well.

> One thing that might be nice, and showed a lot of promise here is to
> either age down by subtracting instead of dividing to make it less
> aggressive. It is already hard enough for pages to get referenced
> enough to move up the scale.

Oh definately, I've tried it with linear page aging and it works
a lot better. I'm just not including that in my patch right now
because I don't want to mix policy and mechanism right now and I
want to really get the mechanism right before moving on to other
stuff.

> Or use a similar approach as I have in my patch, age up periodically,
> but only age down when there is memory shortage,

Where can I get your patch ?

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

