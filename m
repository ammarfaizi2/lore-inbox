Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSJQAwB>; Wed, 16 Oct 2002 20:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSJQAwB>; Wed, 16 Oct 2002 20:52:01 -0400
Received: from mnh-1-14.mv.com ([207.22.10.46]:9733 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261593AbSJQAv6>;
	Wed, 16 Oct 2002 20:51:58 -0400
Message-Id: <200210170202.VAA05667@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: David Coulson <david@davidcoulson.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: wstearns@posbox.com, linux-kernel@vger.kernel.org,
       UML devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [uml-devel] Re: swap_dup/swap_free errors with 2.4.20-pre10 
In-Reply-To: Your message of "Wed, 16 Oct 2002 23:14:50 +0100."
             <3DADE4DA.9080508@davidcoulson.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 Oct 2002 21:02:07 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david@davidcoulson.net said:
> I had weird lockups under 2.4.20-pre9, where the system would behave
> oddly - Most commands would work, but 'ps' simply locked up and I
> couldn't Ctrl-C out of it.

I've seen this bug multiple times.  Basically, something is holding a
mm_sem and not letting go.  Anything that walks the process list hangs.
Ultimately, this hangs anything that's remotely useful, and you have to
crash the box.

I've seen it on my laptop several times, and it hung a UML server that we
have.  UML is frequently, but not always involved.

We got a sysrq t from the UML server.  I posted to lkml about it, with no
response.  You can see that at
	http://marc.theaimsgroup.com/?l=linux-kernel&m=103351640614665&w=2

One factoid that I forgot to mention there is that when it happens on my 
laptop, the disk activity light is stuck on.

				Jeff

