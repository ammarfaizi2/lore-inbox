Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934384AbWKUPe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934384AbWKUPe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934386AbWKUPe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:34:58 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:12643 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S934384AbWKUPe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:34:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LK5ynGRxn0Y+ziacMqeD/4SaE3oHUHAvcExevjAuWh4r8s5DQIhEeH5RmRqEILKcrqwH1gqTeLLrEl8Z4VQFNvCmrQin4noVgWEldIqByZ5OAJPYfXg8w7kuhvEwj5DLjgumtVb4R66ewy4b7Yxns3FlXOGL9LLY49LGJ/BjIuk=
Message-ID: <3a5b1be00611210734k79c81305q7b229139c2b17ef6@mail.gmail.com>
Date: Tue, 21 Nov 2006 17:34:54 +0200
From: "Komal Shah" <komal.shah802003@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: Siemens sx1: merge framebuffer support
Cc: Vladimir <vovan888@gmail.com>, "Tony Lindgren" <tony@atomide.com>,
       "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0611211503190.32103@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061118181607.GA15275@elf.ucw.cz>
	 <20061120190404.GD4597@atomide.com>
	 <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com>
	 <Pine.LNX.4.64.0611211503190.32103@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/06, James Simmons <jsimmons@infradead.org> wrote:
>
> Can you post the framebufer driver to the framebuffer list. We like to do
> peer review. Thank you :-)
>
> On Tue, 21 Nov 2006, Vladimir wrote:
>
> > 2006/11/20, Tony Lindgren <tony@atomide.com>:
> > > * Pavel Machek <pavel@ucw.cz> [061118 18:16]:
> > > > From: Vladimir Ananiev <vovan888@gmail.com>
> > > >
> > > > Framebuffer support for Siemens SX1; this is second big patch. (Third
> > > > one will be mixer/sound support). Support is simple / pretty minimal,
> > > > but seems to work okay (and is somehow important for a cell phone :-).
> > >
> > > Pushed to linux-omap. I guess you're planning to send the missing
> > > Kconfig + Makefile patch for this?
> > >
> > > Also, it would be better to use omap_mcbsp_xmit_word() or
> > > omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
> > > it does not do any checking that it worked. The aic23 and tsc2101
> > > audio in linux-omap tree in general has the same problem.
> > >
> > > Regards,
> > >
> > > Tony
> > >
> >
> > Hmm. McBSP3 in SX1 is used in "GPIO mode". The only line used is CLKX,
> > so I think OMAP_MCBSP_WRITE would be enough. Am I wrong ?
> > -

Again, framebuffer support patch is based on the omap framebuffer
driver, which is not yet submitted to upstream/fbdevel list. sx1
framebuffer support just fill up the hooks required by -omap fb driver
framework.

-- 
---Komal Shah
http://komalshah.blogspot.com
