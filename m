Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVACFJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVACFJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 00:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVACFJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 00:09:05 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:19866 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261382AbVACFJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 00:09:00 -0500
Date: Mon, 3 Jan 2005 06:10:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kconfig: avoid temporary file
Message-ID: <20050103051002.GB8113@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org> <20041230235216.GB9450@mars.ravnborg.org> <200501030155.05203.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501030155.05203.zippel@linux-m68k.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 01:55:04AM +0100, Roman Zippel wrote:
> 
> I'm not really against the change, but the reason is weird. In the end the 
> string is still written to a file anyway...
Next step is to integrate Petr Baudis patch to link lxdialog with mconf.
Then it is nice to get rid of the file based interface.
 
> > +/* Growable string. Allocates memory as needed when string expands */
> > +struct gstr {
> > + char *s;
> > + size_t len;
> > +};
> 
> I would prefer something more like this:
> 
> struct gstr {
>  int size;
>  char s[0];
> };
> 
> and this would be better names for the functions:
> 
> struct gstr *str_new(void);
> void str_free(struct gstr *gs);
> void str_append(struct gstr *gs, const char *s);
> 
> It would be useful to have these sort of functions in the library, so we can 
> e.g. use them to dynamically generate the help text.

I will update my patch with your suggestions later this week.

	Sam
