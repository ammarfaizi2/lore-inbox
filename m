Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTBIEvE>; Sat, 8 Feb 2003 23:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbTBIEvE>; Sat, 8 Feb 2003 23:51:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52490 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267176AbTBIEvD>; Sat, 8 Feb 2003 23:51:03 -0500
Date: Sat, 8 Feb 2003 20:57:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <Pine.LNX.4.44.0302082049420.4686-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302082056040.4726-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Feb 2003, Linus Torvalds wrote:
> 
> Looks like kernel threads still go crazy at shutdown. I saw the migration 
> threads apparently hogging the CPU.

Never mind, I didn't merge your patch correctly, I still had my old one 
there that allowed setting signal-pending even for a blocked signal (and 
thus would confuse all the kernel threads that didn't expect to ever have 
somebody claim they had pending signals).

I think your patch is ok.

		Linus

