Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbTILCiT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTILCiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:38:19 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:42953
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S261223AbTILCiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:38:18 -0400
Date: Thu, 11 Sep 2003 19:38:14 -0700
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: bttv bug
Message-ID: <20030912023814.GA5274@nasledov.com>
References: <20030910064158.GA19930@nasledov.com> <20030910074123.GH18280@vitelus.com> <3F5F99AD.6080502@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5F99AD.6080502@vgertech.com>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 10, 2003 at 10:37:49PM +0100, Nuno Silva wrote:
> Aaron Lehmann wrote:
> >Can you reproduce it without the nvidia module and produce a call
> >trace that doesn't include nvidia symbols?

It seems to work even with the nvidia module loaded, but once I start X, it
stops working. I thought that perhaps the patch to the nvidia kernel module
for -test5 was broken, so I used my older 2.6 nvidia kernel module source
and replaced the call to kdev_val() with MINOR() but that still did not fix
the problem. I can cat /dev/video0 before starting X, but afterwards it
says "Device or resouce busy", even after I kill X.

> Yes, and then try bttv patches from http://bytesex.org/bttv/
> 
> 2.6.0's bttv driver is misbehaving in my setup for ages... Try bytesex's 
> patches and report back, please.

I tried this set of patches and it didn't do anything for me either.

So am I pretty much on my own with this problem? Does anyone use a Bt878 card
with an nvidia card under 2.6? It's strange that it used to work just fine,
but after upgrading it stopped working. I might try downgrading later to
-test4, but it would be unfortunate to have to run an earlier kernel without
the VIA8237SATA chipset merged in =\

I read somewhere that Nvidia cards do not support the overlay extension, but
I had xawtv working just fine if I disabled Xv, and it worked even better if
I used grabdisplay.
-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
