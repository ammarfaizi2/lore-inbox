Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273930AbRIXOmH>; Mon, 24 Sep 2001 10:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273926AbRIXOlt>; Mon, 24 Sep 2001 10:41:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5903 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273925AbRIXOlo>;
	Mon, 24 Sep 2001 10:41:44 -0400
Date: Mon, 24 Sep 2001 11:42:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux VM design
In-Reply-To: <12730310183.20010924170539@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33L.0109241138130.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[grrrrr, the dog was sitting against my arm and I pressed the
wrong key ;)]

On Mon, 24 Sep 2001, VDA wrote:

> >Virtual Memory Management Policy
> >--------------------------------
> >The basic principle of the Linux VM system is page aging.

> is better than plain simple LRU?

All research I've seen indicates that it's better to take
frequency into account as well instead of only access
recency.

Plain LRU just breaks down under sequential IO, LRU with
a large enough inactive list should hold up decently under
streaming IO, but only a replacement strategy which keeps
access frequency into account too will be able to make
proper decisions as to which pages to keep in memory and
which pages to throw out.

Note that it's not me making this up, it's simply the info
I've seen everywhere ... I don't like reinventing the wheel ;)

> We definitely need VM FAQ to have these questions answered once per VM
> design, not once per week :-)

Go ahead, make on on the Linux-MM wiki:

	http://linux-mm.org/wiki/

(note that for some reason the thing gives an internal
server error once in a while ... I haven't yet been able
to find a pattern to it, so I it's not fixed yet)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

