Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbTI3Ov5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTI3Ov5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:51:57 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:34515 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261549AbTI3Ovz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:51:55 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "David S. Miller" <davem@redhat.com>, bunk@fs.tum.de,
       acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030930142154.GA28501@thunk.org>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030929220916.19c9c90d.davem@redhat.com>
	 <1064903562.6154.160.camel@imladris.demon.co.uk>
	 <20030930000302.3e1bf8bb.davem@redhat.com>
	 <1064907572.21551.31.camel@hades.cambridge.redhat.com>
	 <20030930010855.095c2c35.davem@redhat.com>
	 <1064910398.21551.41.camel@hades.cambridge.redhat.com>
	 <20030930142154.GA28501@thunk.org>
Content-Type: text/plain
Message-Id: <1064933510.21551.141.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 30 Sep 2003 15:51:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 10:21 -0400, Theodore Ts'o wrote:
> On Tue, Sep 30, 2003 at 09:26:38AM +0100, David Woodhouse wrote:
> > > The suggestions I see do nothing to enhance the kernel tree as it currently
> > > stands.  If you wish to prevent the kernel image from changing due to
> > > out-of-tree modules being built, fine, but don't impose this restriction
> > > upon in-kernel modules.
> > 
> > It's a matter of taste. As I said, it's your right to disagree.
> > 
> > Some time during 2.7 I'm sure one of the many people who agree with
> > Adrian and myself will send patches to Linus and he'll get to arbitrate.
> 
> 
> FWIW, I agree with Dave.  

It would be difficult to have an opinion on the matter without agreeing
with one of us :)

>  the user may
> have a really hard time figuring out that CONFIG_infrastructure is the
> way to make a particular device driver appear.

To take your chosen example of CONFIG_NET_RADIO.... if your user cannot
determine that in order to enable support for her WaveLAN card she must
first enable the option marked
"Wireless LAN drivers (non-hamradio) & Wireless Extensions"
then I respectfully suggest that you quietly take her out back and shoot
her.

> For that reason, I tend to prefer the approach of simply enabling a
> device driver, and then letting that force a change in the base kernel
> to include any necessary base infrastructure in the kernel if
> necessary. 

Unlike the approach taken by your example.

Note that in that particular case we'd probably have the 'guard' option
"Wireless LAN drivers" _anyway_, even if nothing at _all_ depends upon
it other than configuration options.

Just like we have CONFIG_NET_ETHERNET, CONFIG_NET_VENDOR_3COM,
CONFIG_NET_ISA, CONFIG_NET_PCI and other similar options to keep the
config sane.

Such 'infrastructure' options, whether they actually make a difference
to the resulting kernel or not, are perfectly normal, acceptable and
understandable.

-- 
dwmw2

