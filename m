Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSG2CCK>; Sun, 28 Jul 2002 22:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSG2CCK>; Sun, 28 Jul 2002 22:02:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:260 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316051AbSG2CCK>;
	Sun, 28 Jul 2002 22:02:10 -0400
Message-ID: <3D44A4EB.C5EE33@zip.com.au>
Date: Sun, 28 Jul 2002 19:14:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of 
 PAGE_{CACHE_,}{MASK,ALIGN}
References: <20020729005612.GM1201@dualathlon.random> <Pine.LNX.4.44L.0207282205300.3086-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 29 Jul 2002, Andrea Arcangeli wrote:
> 
> > if you look at DaveM first full rmap implementation it never had a
> > pte-chain. He used the same rmap logic we always hand in linux since the
> > first 2.1 kernel I looked at, to handle correctly truncate against
> > MAP_SHARED. Unfortunately that's not very efficient and requires some
> > metadata allocation for anonymous pages (that's the address space
> > pointer, anon pages regularly doesn't have a dedicated address space),
> 
> Together with the K42 people we found a way to avoid the
> badnesses of an object-based VM.
> 

eek.  Please let's not tie the delivery of the 2.6 kernel to
the success of this R&D effort.  We need reasonable-sized fixes, fast,
for the current problems so that people who have feature work banked
up can get going on it.

Plus, staying close to the 2.4 rmap VM allows us to leverage the
testing and experience which that has had, yes?

-
