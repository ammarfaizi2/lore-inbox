Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSGVUCZ>; Mon, 22 Jul 2002 16:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317798AbSGVUCZ>; Mon, 22 Jul 2002 16:02:25 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16137 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317793AbSGVUCY>; Mon, 22 Jul 2002 16:02:24 -0400
Date: Mon, 22 Jul 2002 17:03:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Paul Larson <plars@austin.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
In-Reply-To: <1027366468.5170.26.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.44L.0207221657460.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul 2002, Paul Larson wrote:

> Encountered this first with Linux-2.5.25+rmap and it looks like the
> problem also slipped into 2.5.27.  The same machine boots fine with a
> vanilla 2.5.25 or 2.5.26, but gets this on boot with rmap.  The machine
> is an 8-way PIII-700.

Bill Irwin has told me about a rare bug with exec() mapping
garbage into the address space of a process, which might
trigger this bug check the next time that process exec()s.

I've gotten two reports of this bug now, but have no idea
what particular combination of hardware / compiler / config
triggers the bug. The rmap code seems to have survived akpm's
stress tests so it's probably not a simple bug to track down ;/

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


