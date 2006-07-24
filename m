Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWGXNPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWGXNPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWGXNPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:15:50 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:26519 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932147AbWGXNPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:15:50 -0400
Date: Mon, 24 Jul 2006 15:15:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] kconfig/lxdialog: add bluetitle color scheme
Message-ID: <20060724131528.GB23210@mars.ravnborg.org>
References: <20060724113641.GA22806@mars.ravnborg.org> <20060724113914.GD22806@mars.ravnborg.org> <Pine.LNX.4.64.0607241425440.6762@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607241425440.6762@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 02:28:24PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 24 Jul 2006, Sam Ravnborg wrote:
> 
> > +static void set_bluetitle_theme(void)
> > +{
> > +	DLG_MODIFY(title, COLOR_BLUE, COLOR_WHITE,  true);
> > +	DLG_MODIFY(button_label_active, COLOR_BLUE, COLOR_BLUE,   true);
> > +	DLG_MODIFY(searchbox_title,     COLOR_BLUE, COLOR_WHITE,  true);
> > +	DLG_MODIFY(position_indicator,  COLOR_BLUE, COLOR_WHITE,  true);
> > +	DLG_MODIFY(tag,                 COLOR_BLUE, COLOR_WHITE,  true);
> > +	DLG_MODIFY(tag_selected,        COLOR_BLUE, COLOR_BLUE,   true);
> > +	DLG_MODIFY(tag_key,             COLOR_BLUE, COLOR_WHITE,  true);
> > +	DLG_MODIFY(tag_key_selected,    COLOR_BLUE, COLOR_BLUE,   true);
> > +}
> 
> In general I would like to see this one become the default, as yellow on 
> white is really terrible, but this one needs fixing too - blue on blue is 
> not really readable either. :)

I blindly replaced yellow with blue.
New version looks like this:
static void set_bluetitle_theme(void)
{
        DLG_MODIFY(title,   COLOR_BLUE, COLOR_WHITE,  true);
        DLG_MODIFY(tag,     COLOR_BLUE, COLOR_WHITE,  true);
        DLG_MODIFY(tag_key, COLOR_BLUE, COLOR_WHITE,  true);
}

The classic color scheme is quite readable on my display.

I can make bluetitle default but keep classic as an option.
Will try this in next version of the patchset.

	Sam
