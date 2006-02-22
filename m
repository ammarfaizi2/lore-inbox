Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWBVTki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWBVTki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWBVTki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:40:38 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:27873
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750851AbWBVTkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:40:37 -0500
Date: Wed, 22 Feb 2006 11:40:24 -0800
From: Greg KH <gregkh@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Gabor Gombas <gombasg@sztaki.hu>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi,
       bunk@stusta.de, rml@novell.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222194024.GA15703@suse.de>
References: <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222191832.GA14638@suse.de> <1140636588.2979.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140636588.2979.66.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 08:29:48PM +0100, Arjan van de Ven wrote:
> On Wed, 2006-02-22 at 11:18 -0800, Greg KH wrote:
> > What about trying a stock 2.6.6 or so kernel?  Does that work
> > differently from 2.6.15?
> 
> ... however it's very much designed only for the kernel that comes with
> it (with "it's" I mean all the userspace infrastructure); all the
> changes and additions since 2.6.9 aren't incorporated so you probably
> really want new alsa, new initscripts, new mkinitrd, new
> module-init-tools. some because of abi changes since 2.6.9, others
> because the kernel grew capabilities that are really needed for "nice"
> behavior.

I totally agree.  Distros are changing into two different groups these
days:
	- everything tied together and intregrated nicely for a specific
	  kernel version, userspace tool versions, etc.
	- flexible and works with multiple kernel versions, different
	  userspace tools, etc.

Distros in the first category are the "enterprise" releases (RHEL, SLES,
etc.), as well as some consumer oriented distros (SuSE, Ubuntu, Fedora
possibly.)

More flexible distros that handle different kernel versions are Gentoo,
Debian, and probably Fedora.

And this is a natural progression as people try to provide a more
complete "solution" for users.

When people to complain that they can't run a "kernel-of-the-day" on
their "enterprise" distro, they are not realizing that that distro was
just not developed to support that kind of thing at all.

So, in short, if you are going to do kernel development, pick a distro
that handles different kernel versions.  Likewise, if you are doing
userspace development (X.org, HAL, KDE, Gnome, etc.) you pick a distro
that allows you to change that level of the stack.

thanks,

greg k-h
