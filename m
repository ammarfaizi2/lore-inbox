Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWENIOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWENIOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 04:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWENIOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 04:14:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:57823 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751343AbWENIOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 04:14:17 -0400
Date: Sun, 14 May 2006 10:13:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Silly bitmap size accounting fix
Message-ID: <20060514081353.GA779@elte.hu>
References: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com> <20060512091451.GA18145@elte.hu> <4465386B.9090804@yahoo.com.au> <Pine.LNX.4.58.0605131010110.27003@gandalf.stny.rr.com> <s5hpsiivsw8.wl%tiwai@suse.de> <4465FEFD.9050603@yahoo.com.au> <Pine.LNX.4.58.0605131157220.27751@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605131157220.27751@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> -#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
> -
>  typedef struct runqueue runqueue_t;
> 
>  struct prio_array {
>  	unsigned int nr_active;
> -	unsigned long bitmap[BITMAP_SIZE];
> +	DECLARE_BITMAP(bitmap, MAX_PRIO+1); /* include 1 bit for delimiter */
>  	struct list_head queue[MAX_PRIO];
>  };

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
