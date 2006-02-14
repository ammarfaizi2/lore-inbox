Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWBNAIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWBNAIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWBNAIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:08:20 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:28269 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964863AbWBNAIT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:08:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bApmrNehR6CnXZnkOjp4HuTkkZKD6kbtlUqdiXblCHn07s03SCcbJwmCM6IrgF4WW6KXno8BWMTpww5eHtMw32C2bzs4oZr1HnmgW0lYJuAJoGb+UN4OUZL6aRnVVrMDqyKYJlN7z5WM9JdYxQ4eAbnmOVilHbAB0dCI0StLuOg=
Message-ID: <21d7e9970602131608y77c35b4fn63b8eeb4101a44d1@mail.gmail.com>
Date: Tue, 14 Feb 2006 11:08:16 +1100
From: Dave Airlie <airlied@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.16-rc3: more regressions
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
In-Reply-To: <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060213170945.GB6137@stusta.de>
	 <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
	 <20060213174658.GC23048@redhat.com>
	 <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> DaveA, I'll apply this for now. Comments?
>

(sorry - I've been finding my way back home from Xdevconf, just landed)...

I asked DaveJ I believe in one thread to disable Load "dri" in his
xorg.conf and report back,

the X.org driver contains problems not the DRM driver, however adding
the PCI ID to the DRM driver will cause the X.org driver to enable
buggy features..

I cannot fix this from the DRM side, either we enable DRM for these
cards at some point or we don't, ideally the X.org driver wouldn't
enable DRI by default for r300 class cards..

There may be some other issues however that Ben is currently looking
into with the memory manager setup,

I've tested the r300 on the 5460 rv350, and I've heard the rv370
doesn't have any great differences, the Xpress 200 is a mess and I'm
not accepting any patches for them until someone with one that knows
what they are doing gets it working..

Dave.

Dave.
