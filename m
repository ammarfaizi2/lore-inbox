Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263164AbSJBO4C>; Wed, 2 Oct 2002 10:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbSJBO4C>; Wed, 2 Oct 2002 10:56:02 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24494 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263164AbSJBO4B>; Wed, 2 Oct 2002 10:56:01 -0400
Date: Wed, 02 Oct 2002 07:59:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] dump_stack() cleanup, BK-curr
Message-ID: <934212386.1033545583@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0210021112020.6201-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210021112020.6201-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  void dump_stack(void)
>  {
> -	show_stack(0);
> +	unsigned long stack;
> +
> +	show_trace(&stack);
>  }

Doesn't this mean that dump_stack no longer dumps the stack?
(seems somewhat counter-intuitive)

Can't code which only wants a trace just call show_trace instead?

M.

