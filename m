Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVKOAEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVKOAEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVKOAEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:04:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932255AbVKOAEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:04:48 -0500
Date: Mon, 14 Nov 2005 16:05:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2: no .config.old any more?
Message-Id: <20051114160502.6ef9d1e8.akpm@osdl.org>
In-Reply-To: <43792372.2010409@g-house.de>
References: <43792372.2010409@g-house.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:
>
> 
> hi,
> 
> i noticed that 2.6.14-mm2 does not generate a .config.old anymore, so that 
> i can undo changes. i see that the Kconfig system is probably in flux 
> again ("Why did oldconfig's behavior change in 2.6.15-rc1?"), but i have 
> not seen this issue being reported:

Yeah, sorry, the diff you noticed is a horrid seven-second-hack I've
carried in my tree since the new Kconfig stuff went in (2.5.early) because
I want my .config to be a symlink to a revision-controlled file and the
Kconfig system (brokely) insists on blowing away the symlink each time you
run it.

A proper patch (which maybe does an lstat+special-stuff) would be nice.

But that particular diff only appears in the -mm rollup when I'm carrying
other patches against confdata.c, which rarely happens.  So it'll go away
again.


