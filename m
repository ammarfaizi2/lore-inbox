Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWGXMZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWGXMZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 08:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWGXMZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 08:25:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48842 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932127AbWGXMZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 08:25:34 -0400
Date: Mon, 24 Jul 2006 14:25:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] kconfig/lxdialog: add support for color themes and
 add blackbg theme
In-Reply-To: <20060724113833.GC22806@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0607241424360.6762@scrub.home>
References: <20060724113641.GA22806@mars.ravnborg.org>
 <20060724113833.GC22806@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Jul 2006, Sam Ravnborg wrote:

> +static int set_color_theme(const char *theme)
> +{
> +	int use_color = 1;
> +	if (!strncasecmp (theme, "blackbg", sizeof("blackbg")))
> +		set_blackbg_theme();
> +	else if (!strncasecmp(theme, "mono", sizeof("mono")))
> +		use_color = 0;
> +	return use_color;
> +}

This segfaults if MENUCONFIG_COLOR isn't set.

bye, Roman
