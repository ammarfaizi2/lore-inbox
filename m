Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSGQUGR>; Wed, 17 Jul 2002 16:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSGQUGR>; Wed, 17 Jul 2002 16:06:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46260 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316610AbSGQUGQ>;
	Wed, 17 Jul 2002 16:06:16 -0400
Date: Thu, 18 Jul 2002 22:08:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Sam Mason <mason@f2s.com>
Cc: shreenivasa H V <shreenihv@usa.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Gang Scheduling in linux
In-Reply-To: <20020717201417.GA9546@sam.home.net>
Message-ID: <Pine.LNX.4.44.0207182206280.6752-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Jul 2002, Sam Mason wrote:

> It's mainly used for programs that needs lots of processing power
> chucked at a specific problem, the problem is first broken down into
> several small pieces and each part is sent off to a different processor.  
> When each piece has been processed, they are all recombined and the rest
> of the calculation is continued.  The problem with this is that if any
> one of the pieces is delayed, all the processors will be idle waiting
> for the interrupted piece to be processed, before they can process the
> next set of pieces.

well, how does gang scheduling solve this problem? Even gang-scheduled
tasks might be interrupted anytime on any CPU, by higher-priority tasks,
thus causing a delay.

	Ingo

