Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311273AbSDSGo4>; Fri, 19 Apr 2002 02:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311587AbSDSGoz>; Fri, 19 Apr 2002 02:44:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35815 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S311273AbSDSGoy>;
	Fri, 19 Apr 2002 02:44:54 -0400
Date: Fri, 19 Apr 2002 06:41:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Erich Focht <efocht@ess.nec.de>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] migration thread fix
In-Reply-To: <20020419064052.GB21206@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0204190639140.3975-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Apr 2002, William Lee Irwin III wrote:

> > looks perfectly good to me. Even with wli's patch i saw some migration
> > thread initialization weirdnesses.
> 
> It's a bit of a moot point, but I'd be interested in knowing what sort
> of weirdnesses those might be for my own edification.

a HT box wouldnt boot without an artificial mdelay(1000) in
migration_init() - while i havent fully debugged it (given Erich's patch),
it appeared to be some sort of race between idle thread startup and
migration init.

	Ingo

