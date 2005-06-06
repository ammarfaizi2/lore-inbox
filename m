Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVFFVJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVFFVJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVFFVJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:09:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:43394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261656AbVFFVJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:09:23 -0400
Date: Mon, 6 Jun 2005 14:11:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <20050606200512.GF2230@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0506061407520.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050606192654.GA3155@elf.ucw.cz> <42A4AA01.90905@pobox.com>
 <20050606200512.GF2230@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Jun 2005, Pavel Machek wrote:
> 
> Linus, perhaps your scripts are doing something wrong? They should
> have taken From in the description; or did I provide wrong changelog?

My scripts definitely do the expected thing. 

In git, the author is always in the fixed header, and you never look for
it anywhere else. However, in order for the author to _get_ there in the
first place, the person who commits the thing needs to haev the author
info.

In this case it was me, and I get the author information from the email
when I commit an emailed patch. I take it from the first line of the body
if that one is a valid "From:" line, and otherwise I fall back to taking
it from the headers of the email.

So in this case you got tagged, either because the patch came through
Andrew (it has his sign-off) and _he_ sent the email but incorrectly had
you as the "From:" person, or alternatively because you sent the email and
took Andrew's sign-off but didn't put the "From:" in the right spot.

		Linus
