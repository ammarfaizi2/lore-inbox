Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272011AbRHYDJk>; Fri, 24 Aug 2001 23:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272385AbRHYDJa>; Fri, 24 Aug 2001 23:09:30 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:15633 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272013AbRHYDJ0>;
	Fri, 24 Aug 2001 23:09:26 -0400
Date: Sat, 25 Aug 2001 00:09:25 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Marc A. Lehmann" <pcg@goof.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010825012338.B547@cerebro.laendle>
Message-ID: <Pine.LNX.4.33L.0108250007140.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Marc A. Lehmann wrote:
> On Fri, Aug 24, 2001 at 05:19:07PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> > Actually, no.  FIFO would be ok if you had ONE readahead
> > stream going on, but when you have multiple readahead
>
> Do we all agree that read-ahead is actually the problem? ATM, I serve
> ~800 files, read()ing them in turn. When I increase the number of
> threads I have more reads at the same time in the kernel, but the
> absolute number of read() requests decreases.

	[snip evidence beyond all doubt]

Earlier today some talking between VM developers resulted
in us agreeing on trying to fix this problem by implementing
dynamic window scaling for readahead, using heuristics not
all that much different from TCP window scaling.

This should make the system able to withstand a higher load
than currently, while also allowing fast data streams to
work with more efficiently than currently.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

