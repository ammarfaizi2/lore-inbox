Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262553AbSI0RmH>; Fri, 27 Sep 2002 13:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262561AbSI0RmH>; Fri, 27 Sep 2002 13:42:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21008 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262553AbSI0RmG>; Fri, 27 Sep 2002 13:42:06 -0400
Date: Fri, 27 Sep 2002 10:48:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209271941210.16693-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209271047340.14939-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Ingo Molnar wrote:
> 
> pin_page() calls get_user_pages(), which might block in handle_mm_fault().

Ok, I admit that sucks. Maybe that damn writable down() is the right thing 
to do after all. And let's hope most futexes don't block.

		Linus

