Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266832AbUHOR40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266832AbUHOR40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUHOR40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:56:26 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:56717 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266832AbUHOR4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:56:24 -0400
Date: Sun, 15 Aug 2004 19:58:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040815175858.GC7265@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <Pine.LNX.4.61.0408151925260.12687@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408151925260.12687@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 07:28:28PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sat, 14 Aug 2004, Sam Ravnborg wrote:
> 
> > +void expr_get_dep_txt(struct expr *e, char *t)
> 
> What's wrong with expr_print()?
Nothing ;-)
Originally I had in mind expanding string storage using realloc as required.
But my hack became a bit simpler than that, so I could have used it.

> 
> > +	if (menu->sym && menu->sym->dep)
> > +		expr_get_dep_txt(menu->sym->dep, t);
> 
> The dep field of the symbol isn't used currently (it's left from the 
> converter).
Should we delete it then?

> Did you already look at the similiar code in qconf.cc?
No.
If I revisit this then I will do so, and use expr_print().

	Sam
