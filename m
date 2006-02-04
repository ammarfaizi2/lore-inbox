Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWBDJVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWBDJVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWBDJVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:21:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60946 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932214AbWBDJVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:21:13 -0500
Date: Sat, 4 Feb 2006 10:20:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jody McIntyre <scjody@modernduck.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       bcollins@debian.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.ne
Subject: Re: 2.6.16-rc1-mm5: drivers/ieee1394/oui O=... builds broken
Message-ID: <20060204092042.GA9275@mars.ravnborg.org>
References: <20060203000704.3964a39f.akpm@osdl.org> <20060203212507.GR4408@stusta.de> <20060204024354.GA22002@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204024354.GA22002@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 09:43:54PM -0500, Jody McIntyre wrote:
> On Fri, Feb 03, 2006 at 10:25:07PM +0100, Adrian Bunk wrote:
> > ...
> >   OUI2C   drivers/ieee1394/oui.c
> > /bin/sh: drivers/ieee1394/oui2c.sh: No such file or directory
> > make[3]: *** [drivers/ieee1394/oui.c] Error 127
> 
> I can't reproduce this.  What steps are you using to build the kernel?

You need to use make O=some_dir to reproduce it.
like this:

# Create output dir and copy config
mkdir ~/o
cp ieee_config ~/o/.config

# Prepare kernel source
cd $KERNELSRC
make mrproper

# Build kernel
make O=~/o 


Note - the breakage is only in -mm.

	Sam
