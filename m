Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313613AbSDXBXo>; Tue, 23 Apr 2002 21:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314041AbSDXBXn>; Tue, 23 Apr 2002 21:23:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58119 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313613AbSDXBXm>; Tue, 23 Apr 2002 21:23:42 -0400
Subject: Re: Why HZ on i386 is 100 ?
To: george@mvista.com (george anzinger)
Date: Wed, 24 Apr 2002 02:42:06 +0100 (BST)
Cc: ak@suse.de (Andi Kleen), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CC5B17B.4E9ACA7C@mvista.com> from "george anzinger" at Apr 23, 2002 12:09:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E170BnK-0001VB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I must not be making my self clear :)  The overhead has nothing to do
> with hardware.  It is all timer list insertion and deletion.  The
> problem is that we need to do this at context switch rates, which are
> MUCH higher that tick rates and, even with the O(1) insertion code,
> cause the overhead to increase above the ticked overhead.

I remain unconvinced. Firstly the timer changes do not have to 
occur at schedule rate unless your implementaiton is incredibly naiive.
Secondly for the specfic schedule case done that way, it would be even more
naiive to use the standard timer api over a single compare to getthe
timer list versus schedule clock.
