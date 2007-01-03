Return-Path: <linux-kernel-owner+w=401wt.eu-S932109AbXACV6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbXACV6w (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbXACV6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:58:52 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:39790 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109AbXACV6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:58:51 -0500
Date: Wed, 3 Jan 2007 22:58:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pelle Svensson <pelle2004@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Symbol links to only needed and targeted source files
Message-ID: <20070103215850.GA32137@uranus.ravnborg.org>
References: <6bb9c1030701030724k4ca544cfg364e28059cf5dfe@mail.gmail.com> <20070103162409.GA30071@uranus.ravnborg.org> <6bb9c1030701031314l1b57bd2brffb61cce68a7174@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb9c1030701031314l1b57bd2brffb61cce68a7174@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 10:14:43PM +0100, Pelle Svensson wrote:
> Hi Sam,
> 
> You misunderstand me I think, I already using a separate output directory.
> What I like to do is a separate 'source tree' with only valid files
> for my configuration. In that way, when I use grep for instance,
> I would only hit valid files and not 50 other files which are
> not in the current build configuration.

I see.
There is nothing in kbuild that will help you to achieve this.
If you build the kernel and parse all .*.cmd files then
you can build a complete list of files used and create your
symlinked tree.
But then you need a fully build kernel to do so.

I see no easy way to get the info without building the kernel
and if we do this only as a preprocessing step then we will
most likely not integrate it in kbuild since the user base will
be small. But if you hack up something lets take a look at it.

	Sam
