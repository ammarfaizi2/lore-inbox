Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWBMTUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWBMTUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWBMTUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:20:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61579 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932240AbWBMTUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:20:36 -0500
Date: Mon, 13 Feb 2006 11:17:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <20060213190907.GD3588@stusta.de>
Message-ID: <Pine.LNX.4.64.0602131115010.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
 <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org> <20060213183445.GA3588@stusta.de>
 <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org> <20060213190907.GD3588@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Adrian Bunk wrote:
> 
> The one thing I have not yet been proven wrong for is that this PCI id 
> is the only one we have in this driver for an RV370.

It definitely is an RV370, you're right in that. I'm too lazy to actually 
see if the other entries that claim to be RV350's really are RV350's.

So I decided to just remove it. Even if there is some other bug that could 
make it work again, we can always just re-add it at that time. In the 
meantime, this should fix both DaveJs and Mauros problems, and is clearly 
no worse than 2.6.15 (which also didn't recognize the card), so...

		Linus
