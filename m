Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSKRPyH>; Mon, 18 Nov 2002 10:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSKRPyH>; Mon, 18 Nov 2002 10:54:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14353 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262804AbSKRPyF>; Mon, 18 Nov 2002 10:54:05 -0500
Date: Mon, 18 Nov 2002 08:00:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <3DD88CB5.5070904@redhat.com>
Message-ID: <Pine.LNX.4.44.0211180800240.2454-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Ulrich Drepper wrote:
> 
> which works for me.  But since in schedule_tail() the code reads
> 
> +       if (current->user_tid)
> +               put_user(current->pid, current->user_tid);
> 
> this enables writing the TID even if CLONE_CHILD_SETTID isn't set.  The
> question is: how to access the clone flag information in the child?

The alternate approach is to just say that using CLEARTID without SETTID 
is a bug. I think that's the right approach.

		Linus

