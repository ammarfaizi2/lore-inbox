Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268249AbSIRQ4N>; Wed, 18 Sep 2002 12:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268122AbSIRQy5>; Wed, 18 Sep 2002 12:54:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62992 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268129AbSIRQyV>; Wed, 18 Sep 2002 12:54:21 -0400
Date: Wed, 18 Sep 2002 09:59:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Ingo Molnar <mingo@elte.hu>, Andries Brouwer <aebr@win.tue.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918164553.GB28202@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209180957270.2854-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, William Lee Irwin III wrote:
> 
> The lockups I see range from hours to "it spun over the weekend, time
> to pull the plug".

But that is not because it walks the thread list once, it's because it 
walks it, and loops walking in, and loops walking it some more.

All of which is avoided by just forcing the pid space to be "sufficiently 
large".

			Linus

