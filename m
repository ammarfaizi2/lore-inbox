Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWBNAdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWBNAdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWBNAdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:33:36 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:23700 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030336AbWBNAdf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:33:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sbv1f2696AAKa1t+F5y0hWjJwyMwem0QLuAzs/c1x3EygU0XST9F3nDdzc54NDeKJnVjsiS11/0chI79Whrd5EnzgE/8Vh10HiBUWbkBqwkgoGksXvh5NRZe35ws/xKEnJoYGDWJAYpW2w/IHrcq/m5awqDJu/lI75jjAQfdC8Q=
Message-ID: <21d7e9970602131633v232a97ebncc1323c425a179f2@mail.gmail.com>
Date: Tue, 14 Feb 2006 11:33:33 +1100
From: Dave Airlie <airlied@gmail.com>
To: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <20060214002914.GB15878@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060213170945.GB6137@stusta.de>
	 <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
	 <20060213174658.GC23048@redhat.com>
	 <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
	 <21d7e9970602131608y77c35b4fn63b8eeb4101a44d1@mail.gmail.com>
	 <20060214002914.GB15878@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nding my way back home from Xdevconf, just landed)...
>  >
>  > I asked DaveJ I believe in one thread to disable Load "dri" in his
>  > xorg.conf and report back,
>
> Ah sorry about that.  You were just about to go to LCA when that came
> up, so I figured I'd wait until you had time to look at it again :)
>
> There's a log at http://people.redhat.com/davej/Xorg.0.log
> That doesn't have drm disabled, but it is being run on a kernel
> with the pci id commented out.  I'm a bit reluctant to reboot
> the workstation to try a non-drm enabled X at the moment, until
> some stuff finishes.  Let me know if that log is insufficient or not.
>

Well the things is not having the PCI id is the same things as
commenting out Load "dri" in the xorg.conf really, X never tries to
initialise the DRM layer on the card, I know this is a bug in the
current 7.0 radeon driver and I'm hoping Ben's fixed can fix this
however, we will end up never being able to turn on DRM support for
r300 cards until X.org 7.1 is widespread or we add some kind of second
stage enable that a new X server can work but I'm not really sure that
this is possible,

The fix is to not load DRI on old X.org r300 installs...

Dave.
