Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289040AbSAOEAX>; Mon, 14 Jan 2002 23:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289076AbSAOEAM>; Mon, 14 Jan 2002 23:00:12 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:9096 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289040AbSAOEAF>; Mon, 14 Jan 2002 23:00:05 -0500
Date: Mon, 14 Jan 2002 20:59:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020115035952.GC3814@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020115013954.GB3814@cpe-24-221-152-185.az.sprintbbd.net> <20020115020758.GA59418@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115020758.GA59418@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 02:07:58AM +0000, John Levon wrote:
> On Mon, Jan 14, 2002 at 06:39:54PM -0700, Tom Rini wrote:
> 
> > Wrong.  She needs to compile a new module for her kernel.  What might be
> > useful is some automagic tool that will find the vendor-provided kernel
> > source tree and config (which is usually /boot/config-`uname -r`, but
> > still findable anyhow)
> 
> autoconf code already exists for this, it's a non-problem.

Er, why on earth is it 'autoconf' tho?  This isn't something that's
necessaryily a CONFIG_xxx issue, it's a 'compile this for me' issue.

> Note they must use
> the config in the header file of the vendor-provided kernel source tree, not
> /boot/config-`uname -r`

And why wouldn't the two match?  If you're running a vendor-provided
kernel, /boot/config-`uname -r` should be the config for the
vendor-provided kernel (and its source tree)...

> There are two cases:
> 
> 1) the vendor source tree is installed and set up with the right config -> use header file
> 
> 2) it's installed and the config has changed. -> use header file

2) should never happen.  I'm not talking about a patch (like said what
i2c does traditionally), I'm talking about driver.[ch].

> I don't see a point in ever looking at /boot/config-`uname -r` instead of
> the source tree, given that we must compile against a tree configured like the
> eventual running kernel anyway.

Because they should be the same thing?  And why do you mention 'eventual
running kernel'.  There is a running kernel.  Compile the module, load
the module, work.  No reboot (or kernel recompile) needed.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
