Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271254AbRHZDlF>; Sat, 25 Aug 2001 23:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271261AbRHZDk4>; Sat, 25 Aug 2001 23:40:56 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:44050 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271254AbRHZDkm>;
	Sat, 25 Aug 2001 23:40:42 -0400
Date: Sun, 26 Aug 2001 00:40:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: John Stoffel <stoffel@casc.com>
Cc: "Marc A. Lehmann" <pcg@goof.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <15240.18121.972361.669914@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.33L.0108260032490.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, John Stoffel wrote:

> Ummm... is this really more of an agreement that Daniel's used-once
> patch is a good idea on a system.  Keep a page around if it's used
> once, but drop it quickly if only used once?

There's a very big difference, though.  With use-once we'll
also quickly drop the pages we have not yet used, that is,
the pages we _are about to use_.

Drop-behind specifically drops the pages we have already
used, giving better protection to the pages we are about
to use.

http://linux-mm.org/wiki/moin.cgi/StreamingIo

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


