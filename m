Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTFHR7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 13:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTFHR7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 13:59:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2824 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263628AbTFHR7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 13:59:36 -0400
Date: Sun, 8 Jun 2003 11:12:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Move BUG/BUG_ON/WARN_ON to asm headers
In-Reply-To: <Pine.SOL.4.30.0306071738580.28622-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0306081106400.6309-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jun 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> What about adding asm-generic/bug.h ?

I personally dislike infrastructure that isn't a big win.

Shared files ("generic" stuff) end up being useful mainly if they are 
_really_ generic, and they do something that takes more effort to do than 
it takes to learn about the generic interface.

For trivial stuff that isn't even really generic (ie several architectures 
are likely to want to tinker with their implementation), trying to have a 
generic version is just not worth it, imho. 

In general, I tend to like independent copies with small (but locally
obvious) variations over one generic one with non-locally-obvious
semantics - things like "mostly people use this version, except if XXXX is 
defined, in which case they use their own" are just a total nightmare in 
my opinion. 

			Linus

