Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVASSSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVASSSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVASSSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:18:43 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:44510 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261818AbVASSSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:18:41 -0500
Date: Wed, 19 Jan 2005 19:18:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andreas Gruenbacher <agruen@suse.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kbuild 2/5] Dont use the running kernels config file by default
In-Reply-To: <1106157119.8642.25.camel@winden.suse.de>
Message-ID: <Pine.LNX.4.61.0501191858060.30794@scrub.home>
References: <20050118184123.729034000.suse.de>  <20050118192608.423265000.suse.de>
  <Pine.LNX.4.61.0501182106340.6118@scrub.home> <1106157119.8642.25.camel@winden.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Jan 2005, Andreas Gruenbacher wrote:

> > > A user ran into the following problem: They grab a SuSE kernel-source
> > > package that is more recent than their running kernel. The tree under
> > > /usr/src/linux is unconfigured by default; there is no .config. User
> > > does a ``make menuconfig'', which gets its default values from
> > > /boot/config-$(uname -r). User tries to build the kernel, which doesn't
> > > work.
> > 
> > NAK. This isn't normally supposed to happen and it shouldn't be as bad 
> > anymore as it used to be. Removing these path doesn't magically create a 
> > working kernel.
> 
> "Not normally supposed to happen" and "shouldn't be as bad anymore"
> aren't very sound arguments.

It's as precise as above problem report. 

> It's fundamentally broken to use a
> semi-random configuration for a kernel source tree that may be
> arbitrarily far apart.

No, it's not. Please provide more information why exactly this is broken.

> It's not uncommon that users who build their own kernel modules often
> are very clueless. Nevertheless we shouldn't cause them pain
> unnecessarily.

So they should first try the 2.6 kernel provided by the distribution and 
then try compiling their own kernel. In this situation it's actually more 
likely that they produce a working kernel with the current behaviour, the 
defconfig is not a guarantee for a working kernel either.
Sorry, but as long as nobody writes an autoconfig tool for the kernel, the 
kernel configuration is not a simple process and any default can only be a 
compromise and may fail. If you have evidence that there are better 
defaults, we can change this, but your problem report above is not enough.

bye, Roman
