Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262131AbRETRu0>; Sun, 20 May 2001 13:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262129AbRETRuQ>; Sun, 20 May 2001 13:50:16 -0400
Received: from chiara.elte.hu ([157.181.150.200]:58638 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262126AbRETRuF>;
	Sun, 20 May 2001 13:50:05 -0400
Date: Sun, 20 May 2001 19:48:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <jacob@chaos2.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 del_timer_sync oops in schedule_timeout
In-Reply-To: <Pine.LNX.4.21.0105191417490.2956-100000@inbetween.blorf.net>
Message-ID: <Pine.LNX.4.33.0105201945370.31113-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Jacob Luna Lundberg wrote:

> This is 2.4.4 with the aic7xxx driver version 6.1.13 dropped in.

> Unable to handle kernel paging request at virtual address 78626970

this appears to be some sort of DMA-corruption or other memory scribble
problem. hexa 78626970 is ASCII "pibx", which shows in the direction of
some sort of disk-related DMA corruption.

we havent had any similar crash in del_timer_sync() for ages.

	Ingo

