Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265407AbRGBSmm>; Mon, 2 Jul 2001 14:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbRGBSmc>; Mon, 2 Jul 2001 14:42:32 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60174 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S265407AbRGBSmU>;
	Mon, 2 Jul 2001 14:42:20 -0400
Date: Mon, 2 Jul 2001 15:42:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Marco Colombo <marco@esi.it>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <mike_phillips@urscorp.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <Pine.LNX.4.33.0106281723490.4236-100000@Megathlon.ESI>
Message-ID: <Pine.LNX.4.33L.0107021538030.14332-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Marco Colombo wrote:

> I'm not sure that, in general, recent pages with only one access are
> still better eviction candidates compared to 8 hours old pages. Here
> we need either another way to detect one-shot activity (like the one
> performed by updatedb),

Fully agreed, but there is one problem with this idea.
Suppose you have a maximum of 20% of your RAM for these
"one-shot" things, now how are you going to be able to
page in an application with a working set of, say, 25%
the size of RAM ?

If you don't have any special measures, the pages from
this "new" application will always be treated as one-shot
pages and the process will never be able to be cached in
memory completely...

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

