Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVFUJI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVFUJI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVFUJHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:07:36 -0400
Received: from coderock.org ([193.77.147.115]:17280 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262091AbVFUJHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:07:09 -0400
Date: Tue, 21 Jun 2005 11:07:01 +0200
From: Domen Puncer <domen@coderock.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] kernel/power/disk.c string fix and if-less iterator
Message-ID: <20050621090701.GJ3906@nd47.coderock.org>
References: <20050620215712.840835000@nd47.coderock.org> <20050620221041.GI2222@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620221041.GI2222@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/05 00:10 +0200, Pavel Machek wrote:
> Hi!
> 
> > The attached patch:
> > 
> > o  Fixes kernel/power/disk.c string declared as 'char *p = "...";' to be
> >    declared as 'char p[] = "...";', as pointed by Jeff Garzik.
> 
> ? Why was char *p ... wrong? Because you could not do sizeof() later?

It usualy generates shorter binary, because there's no pointer variable.
Doesn't seem so in this case:
	   text    data     bss     dec     hex filename
before:	   2333     389       8    2730     aaa kernel/power/disk.o
after:	   2349     389       8    2746     aba kernel/power/disk.o

static const char[] makes it same, so no real gain there either :-(

Sorry for the noise.


	Domen
