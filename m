Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSFIRWl>; Sun, 9 Jun 2002 13:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSFIRWk>; Sun, 9 Jun 2002 13:22:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40698 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S313571AbSFIRWj>; Sun, 9 Jun 2002 13:22:39 -0400
Subject: Re: [PATCH][2.5] make kernel scheduler use list_move_tail (1 occ)
From: Robert Love <rml@tech9.net>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.44.0206090820100.25737-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Jun 2002 10:22:30 -0700
Message-Id: <1023643356.1180.119.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 07:22, Lightweight patch manager wrote:
> This makes the kernel scheduler use list_move_tail instead of more code
>
> [...]
>
> -		list_del(&current->run_list);
> -		list_add_tail(&current->run_list, array->queue + current->prio);
> +		list_move_tail(&current->run_list, array->queue + current->prio);

I guess this would be fine if I knew what list_move_tail did... or if I
had it in my tree:

	[10:11:06]rml@sinai:~/kernel-2.5/linux$ grep -r list_move_tail *
	[10:12:07]rml@sinai:~/kernel-2.5/linux$

???

	Robert Love

