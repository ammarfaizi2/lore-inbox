Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSKRTIt>; Mon, 18 Nov 2002 14:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSKRTIt>; Mon, 18 Nov 2002 14:08:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5903 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264681AbSKRTIt>; Mon, 18 Nov 2002 14:08:49 -0500
Date: Mon, 18 Nov 2002 11:14:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
In-Reply-To: <3DD93B06.5050602@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0211181111080.1186-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Nov 2002, Manfred Spraul wrote:
>
> Not really. calibrate_delay needs interrupts on one cpu.

Good point, I missed that.

I'd still be a lot happier with calibrate_delay() being moved down, we
really shouldn't do things that depend on interrupts if we can't take them
ourselves.

		Linus

