Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTCEARJ>; Tue, 4 Mar 2003 19:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTCEARJ>; Tue, 4 Mar 2003 19:17:09 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:4798 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S264748AbTCEARI>;
	Tue, 4 Mar 2003 19:17:08 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: VM / OOM troubles in 2.4.20-ck4 (-aa VM)
Date: Wed, 5 Mar 2003 11:27:33 +1100
User-Agent: KMail/1.5
References: <Pine.GSO.4.50.0303041249251.5801-100000@quaratino>
In-Reply-To: <Pine.GSO.4.50.0303041249251.5801-100000@quaratino>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303051127.33140.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003 11:58 pm, Alastair Stevens wrote:
> Hi Guys - I was surprised to discover that the very latest 2.4.20
> kernels running the latest -ck patches still have major VM problems,
> even with the -aa VM.
>
> Our dual Athlon server with 512Mb RAM / 1.2Gb swap, and not particularly
> heavily loaded, lasted 81 days with 2.4.20-ck1 under RH8.0, and then
> succumbed with these errors:
>
>   VM error: killing process wineserver
>    _alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>
> This time, it only lasted _3 days_ with -ck4 before the same thing
> happened.
>
> I presume this is the OOM killer? Swap is indeed full, but I've no idea
> why, on a machine that's only running a couple of instances of a small
> Windoze app under WINE.
>
> Is there a problem here? Should I just give up and run 2.5? ;-)

My first guess would be wine. There are all sorts of leaks in that.

I'm not aware of any memory leak / vm problems with -ck although that may be 
possible. However ck4 does not have the OOM killer enabled so it's not that 
in action; you simply have run out of memory and it can't allocate any more. 
Have you tried without the aa vm addons in ck? Does this happen with vanilla 
2.4.20? -ck is a very different branch. 

Con
