Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVFDXpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVFDXpz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 19:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFDXpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 19:45:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbVFDXpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 19:45:43 -0400
Date: Sat, 4 Jun 2005 16:47:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: git-shortlog script
In-Reply-To: <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0506041645490.1876@ppc970.osdl.org>
References: <42A22C20.10002@pobox.com> <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Jun 2005, Linus Torvalds wrote:
> 
> Btw, it shows how broken your merge script is: you don't fill in the 
> AUTHOR field properly for some reason:

Oh, and the reason you didn't notice is that "git-whatchanged" normally 
ignores merges. Do 

	git-rev-list --pretty HEAD ^v2.6.12-rc5 | git-shortlog | less -S

to see what I'm talking about ("show shortlog of all the changes since
v2.6.12-rc5").

		Linus
