Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUKMX30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUKMX30 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUKMX3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:29:24 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:44218 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S261207AbUKMX2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:28:03 -0500
Date: Sun, 14 Nov 2004 00:22:55 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Message-ID: <20041113232255.GA25845@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1099893447.10262.154.camel@gaston> <200411081706.55261.adaplas@hotpop.com> <1099950722.10262.166.camel@gaston> <MPG.1bfa1abaf653d37c98970a@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1bfa1abaf653d37c98970a@news.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 12:07:58AM +0100, Giuseppe Bilotta wrote:
> Benjamin Herrenschmidt wrote:
> > On Mon, 2004-11-08 at 17:06 +0800, Antonino A. Daplas wrote:
> > 
> > > 
> > > How about this patch?  This is almost the original macro in riva_hw.h,
> > > with the __force annotation.
> > 
> > I don't like it neither. It lacks barriers. the rivafb driver
> > notoriously lacks barriers, except in a few places where it was so bad
> > that it actually broke all the time, where we added some. This
> > originates from the X "nv" driver written by Mark Vojkovich who didn't
> > want to hear about barriers for perfs reasons I think.
> 
> Could this be the reason why in 2.6.7 I get solid lockups when 
> switching to nv-driven X and rivafb-driven console? Is there 
> something I could test to see if this is the reason?
Please try 2.6.10-rc1-mm5. It should work there.
 -- Guido
