Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUILVal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUILVal (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUILVal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:30:41 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:7080 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262574AbUILVaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:30:35 -0400
Date: Sun, 12 Sep 2004 23:30:34 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: displaying kbuild dependancies ...
Message-ID: <20040912213034.GD24240@MAIL.13thfloor.at>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <20040911202548.GA31680@MAIL.13thfloor.at> <20040911213931.GA22403@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911213931.GA22403@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 11:39:31PM +0200, Sam Ravnborg wrote:
> On Sat, Sep 11, 2004 at 10:25:48PM +0200, Herbert Poetzl wrote:
> > 
> > Hi Sam!
> > 
> > first, thanks for the kbuild stuff and all the 
> > time spent on that ... I really love it
> > 
> > 
> > from time to time I encounter some issue which
> > usually keeps me busy for a while, and I think
> > there probably is a simpler solution to that ...
> > 
> > the procedure:
> > 
> > I'm configuring a 2.6.X-rcY-bkZ kernel for testing
> > with QEMU, which in my setup basically requires
> > some QEMU specific settings, I usually turn on/off
> > by just editing the .config file by hand, and then
> > invoking 'make oldconfig' ...
> > 
> > to keep the possibility for error low, I usually
> > just remove the entries in question, and oldconfig
> > will ask me the relevant question, leading to a
> > nice config adapted to my purposes ...
> > 
> > the issue:
> > 
> > sometimes a dependancy doesn't allow me to remove
> > a config option, I absolutely have to remove for
> > my setup, like the VGA_CONSOLE, and then the hunt
> > for the option 'requiring' that one unconditinally
> > beginns ...
> > 
> > usually I start with grep and end with trial and
> > error, until I find the malicious dependancy ...
> 
> The only option today is to turn on the debug option
> in 'make xconfig'.

hmm, so no luck for the typical console user  :(

> I have been looking inot something better for menuconfig
> but frankly kconfig is not where I feel most comfortable.

it would be sufficient to be able to turn on some
debug output, which says 'foo selected from bla'
or 'foo disabled, requires bla and whatnot' ...

anyway, thanks for the feedback,
Herbert

> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
