Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287484AbSAHLrn>; Tue, 8 Jan 2002 06:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287427AbSAHLrd>; Tue, 8 Jan 2002 06:47:33 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:16389 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287407AbSAHLra>;
	Tue, 8 Jan 2002 06:47:30 -0500
Date: Tue, 8 Jan 2002 22:43:55 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020108114355.GA25718@krispykreme>
In-Reply-To: <200201071922.g07JMN106760@penguin.transmeta.com> <Pine.LNX.4.33.0201072222100.15970-100000@localhost.localdomain> <20020108113251.GB20897@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108113251.GB20897@krispykreme>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
>  struct prio_array {
>  	int nr_active;
>  	spinlock_t *lock;
>  	runqueue_t *rq;
> -	char bitmap[BITMAP_SIZE];
> +	unsigned long bitmap[3];
>  	list_t queue[MAX_PRIO];
>  };

Sorry, of course this is wrong if sizeof(unsigned long) < 64. But you
get the idea :)

Anton
