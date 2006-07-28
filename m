Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752043AbWG1Qnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbWG1Qnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbWG1Qnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:43:35 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:44724 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752043AbWG1Qne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:43:34 -0400
Date: Fri, 28 Jul 2006 18:43:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] kconfig/lxdialog: color theme support
Message-ID: <20060728164320.GA29662@mars.ravnborg.org>
References: <20060725065640.GA2685@mars.ravnborg.org> <Pine.LNX.4.64.0607270223220.6761@scrub.home> <Pine.LNX.4.61.0607281826200.4972@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0607281826200.4972@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 06:29:05PM +0200, Jan Engelhardt wrote:
> 
> > Second iteration of the patchset to add color theme support to lxdialog.
> > This patchset allow the menuconfig user to select between a number of
> > different color themes for menuconfig:
> > blackbg, classic, mono and bluetitle
> 
> Ain't nobody say the kernel lacks customization!
> 
> It would have been nice to do the following,
> 
> diff --fast -Ndpru -x '*.cmd' lxdialog~/util.c lxdialog/util.c
> --- lxdialog~/util.c	2006-07-28 16:37:28.499577000 +0200
> +++ lxdialog/util.c	2006-07-28 16:52:09.929577000 +0200
> @@ -63,6 +63,42 @@ do {                               \
>  	dlg.dialog.hl = (h);       \
>  } while (0)
>  
> +static void set_classiciv_theme(void)
> +{
> +	dlg = (const struct dialog_info){
> +		.screen                = {0, COLOR_CYAN,   COLOR_BLUE,  true},
> +		.shadow                = {0, COLOR_BLACK,  COLOR_BLACK, true},
> ...
> +		.uarrow                = {0, COLOR_GREEN,  COLOR_WHITE, true},
> + 		.darrow                = {0, COLOR_GREEN,  COLOR_WHITE, true},
> +	};
> +	return;
> +}
> 
> Which uses a nice memcpy call rather than tons of MOVs (assembler insns). 
> Unfortuantely it truncates ->title.

Current schme allows us to have a grand master theme that can be default
and then justified as needed - like in the 'bluetitle' case.

And for this purposes this is all about readability and not code-speed.

	Sam
