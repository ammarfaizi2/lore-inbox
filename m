Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317051AbSFQV4N>; Mon, 17 Jun 2002 17:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSFQV4M>; Mon, 17 Jun 2002 17:56:12 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:15825 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317051AbSFQV4M>; Mon, 17 Jun 2002 17:56:12 -0400
Date: Tue, 18 Jun 2002 07:43:02 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initcall depends
Message-Id: <20020618074302.1bc72b56.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0206162007160.30474-100000@chaos.physics.uiowa.edu>
References: <E17JkO6-0000nW-00@wagner.rustcorp.com.au>
	<Pine.LNX.4.44.0206162007160.30474-100000@chaos.physics.uiowa.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2002 20:17:44 -0500 (CDT)
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
> As you're taking the effort of running some code to figure out the right 
> ordering anyway, have you considered using the the information which is 
> already there today, for all code which can be compiled modular.

Unfortunately, this is rather painful:

	1) File A contains an initcall.
	2) Find Module A which File A is part of.
	3) For each exported symbol used by Module A
		4) Find Module B which exports this symbol.
		5) Find Files B which make up Module B.
		6) For each initcall in Files B, insert a dependency.

Any clues for (2) and (5)?
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
