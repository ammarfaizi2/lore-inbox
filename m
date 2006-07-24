Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWGXNFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWGXNFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWGXNFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:05:19 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:59589 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932141AbWGXNFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:05:18 -0400
Date: Mon, 24 Jul 2006 15:04:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] kconfig/lxdialog: add support for color themes and add blackbg theme
Message-ID: <20060724130458.GA23210@mars.ravnborg.org>
References: <20060724113641.GA22806@mars.ravnborg.org> <20060724113833.GC22806@mars.ravnborg.org> <Pine.LNX.4.64.0607241424360.6762@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607241424360.6762@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 02:25:32PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 24 Jul 2006, Sam Ravnborg wrote:
> 
> > +static int set_color_theme(const char *theme)
> > +{
> > +	int use_color = 1;
> > +	if (!strncasecmp (theme, "blackbg", sizeof("blackbg")))
> > +		set_blackbg_theme();
> > +	else if (!strncasecmp(theme, "mono", sizeof("mono")))
> > +		use_color = 0;
> > +	return use_color;
> > +}
> 
> This segfaults if MENUCONFIG_COLOR isn't set.
Thanks - will fix. I expected str* to be NULL safe...

	Sam
