Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285250AbRL2TGT>; Sat, 29 Dec 2001 14:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285258AbRL2TGJ>; Sat, 29 Dec 2001 14:06:09 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:28433 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S285250AbRL2TGB>;
	Sat, 29 Dec 2001 14:06:01 -0500
To: oxymoron@waste.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Newsgroups: linux.kernel
In-Reply-To: <Pine.LNX.4.43.0112291136350.18183-100000@waste.org>
In-Reply-To: <E16JoEp-000088-00@starship.berlin>
Organization: 
Message-Id: <20011229190600.2556C36DE6@hog.ctrl-c.liu.se>
Date: Sat, 29 Dec 2001 20:06:00 +0100 (CET)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.43.0112291136350.18183-100000@waste.org> you write:
>If my understanding of the new kbuild and configure system is correct,
>make clean and dep should be largely unnecessary and it should be possible
>to build a patchbot that checks for incremental compilability:
>
>for the current kernel release:
>  unpack tree
>  build the tree with default options (unprivileged user, obviously)

One thing that should not be forgotten is the risk of trojan horses
here, in practice the Makefile is a shell script, so to apply any
patch and the compile with it would be a bit dangerous.  It might be
possible to limit the patchbot to only accept code changes, but 
that might remove most of the benefits.  Also, I don't know how much
magic one might do with a properly crafted #include statement, such 
as "#include /etc/passwd" and then the error message will contain
the encypted password for root (shadow passwords fix this specific
problem, but you get the idea :-)

  /Christer
-- 
"Just how much can I get away with and still go to heaven?"
