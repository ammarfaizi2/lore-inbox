Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSG1PyJ>; Sun, 28 Jul 2002 11:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSG1PyJ>; Sun, 28 Jul 2002 11:54:09 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:34910 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S316953AbSG1PyI>; Sun, 28 Jul 2002 11:54:08 -0400
Date: Sun, 28 Jul 2002 18:57:15 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Buddy Lumpkin <b.lumpkin@attbi.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About the need of a swap area
Message-ID: <20020728155715.GX1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Rik van Riel <riel@conectiva.com.br>,
	Buddy Lumpkin <b.lumpkin@attbi.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20020728065830.GT1465@niksula.cs.hut.fi> <Pine.LNX.4.44L.0207281111350.3086-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0207281111350.3086-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 11:11:57AM -0300, you [Rik van Riel] wrote:
> On Sun, 28 Jul 2002, Ville Herva wrote:
> 
> > If you have swap, it makes sense to use it. What doesn't make
> > sense is to waste time waiting for paging to happen.
> 
> Unless of course you're running on battery power...

Well, that of course an entirely different (and I might call it special)
condition. 

In theory you could still write anonymous pages to swap device, and then
have the swap disk spun down/go to powersave state. The swap space is still
in use, but you take the "do not spin up/use the disk, please" requirement
in consideration by not dropping the swap-backed in-memory pages. Once the
swap disk is spun up, you restore the normal operating mode and take
advantage of the still swap-backed anonymous pages (provided of course they
haven't been dirtied in between).

That of course is only theoretical speculation. Surely no os goes that far.
I understand linux even hasn't a mechanism to avoid swapping when power
needs to be saved?


-- v --

v@iki.fi
