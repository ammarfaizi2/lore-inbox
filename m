Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbRHXTIo>; Fri, 24 Aug 2001 15:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272299AbRHXTIe>; Fri, 24 Aug 2001 15:08:34 -0400
Received: from [209.10.41.242] ([209.10.41.242]:2948 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268286AbRHXTIZ>;
	Fri, 24 Aug 2001 15:08:25 -0400
Date: Fri, 24 Aug 2001 16:02:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <200108241833.f7OIX1Q26223@maila.telia.com>
Message-ID: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Roger Larsson wrote:

> Not having the patch gives you another effect - disk arm is
> moving from track to track in a furiously tempo...

Fully agreed, but remember that when you reach the point
where the readahead windows are pushing each other out
you'll be off even worse.

I guess in the long run we should have automatic collapse
of the readahead window when we find that readahead window
thrashing is going on, in the short term I think it is
enough to have the maximum readahead size tunable in /proc,
like what is happening in the -ac kernels.

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

