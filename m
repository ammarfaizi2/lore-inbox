Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbTIGMmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 08:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTIGMmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 08:42:46 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51973 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261596AbTIGMmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 08:42:45 -0400
Date: Sun, 7 Sep 2003 14:42:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       robert@schwebel.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907124237.GA922@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	robert@schwebel.de
References: <20030907112813.GQ14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907112813.GQ14436@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 01:28:13PM +0200, Adrian Bunk wrote:
Could you change this:
> +ifdef CONFIG_CPU_386
> +  CFLAGS_CPU	:= -march=i386
> +endif
> +
>  
> -CFLAGS += $(cflags-y)
> +CFLAGS += $(CFLAGS_CPU)

to:
cpuflags-$(CONFIG_CPU_386) := -march=i386
CFLAGS += $(cflags-y) $(cpuflags-y)

I kept cflags-y, but you may have totally eliminated that?

	Sam
