Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTJLSHI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 14:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTJLSHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 14:07:08 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:31761 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263498AbTJLSHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 14:07:06 -0400
Date: Sun, 12 Oct 2003 20:07:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] Make pmdisk suspend more reliable
Message-ID: <20031012180703.GA2328@mars.ravnborg.org>
Mail-Followup-To: Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org, mochel@osdl.org
References: <20031012161828.GA1728@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012161828.GA1728@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 09:18:28AM -0700, Tony Lindgren wrote:

> --- linux-2.6.0-test7/kernel/power/pmdisk.c-orig	2003-10-12 18:35:58.000000000 +0300
> +++ linux-2.6.0-test7/kernel/power/pmdisk.c	2003-10-12 19:00:32.000000000 +0300
> @@ -35,6 +35,7 @@
>  
>  
>  extern int pmdisk_arch_suspend(int resume);
> +extern int wakeup_bdflush(long nr_pages);

Prototypes in .c files is never a good idea.
wakeup_bdflush is prototyped in include/linux/writeback.h

pmdisk_arch_suspend is expected to be implemented in assembler, which
explain why it is prototypes locally.

	Sam
