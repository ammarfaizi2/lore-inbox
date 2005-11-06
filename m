Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVKFP33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVKFP33 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVKFP33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:29:29 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:18394 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S1750730AbVKFP32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:29:28 -0500
Date: Sun, 6 Nov 2005 16:29:24 +0100
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: 333052@bugs.debian.org, Kay Sievers <kay.sievers@vrfy.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug#333052: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051106152924.GB16987@ojjektum.uhulinux.hu>
References: <436CD1BC.8020102@t-online.de> <20051105173104.GA31048@vrfy.org> <20051105184802.GB25468@ojjektum.uhulinux.hu> <436DA120.9040004@t-online.de> <436E181D.6010507@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436E181D.6010507@t-online.de>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 03:50:05PM +0100, Harald Dunkel wrote:
> Harald Dunkel wrote:
> > 
> > For testing I have added it to Debian's
> > module-init-tools 3.2-pre9. Works for me.
> > 
> 
> No, it doesn't. After the 3rd reboot the
> problem was back.

Well, that's really wierd, It Should Work(tm) :)
Did you apply both patches (Rusty's + mine), or only the latter?

Could you send me debug output please? The first time I met the problem, 
I used a modprobe wrapper which dumped /proc/modules and modprobe 
stdout/stderr to a temp file.

I would like to also mention, that my patch leaves a very little time 
window open, but that's only a problem if module unloading is also 
happening: after parsing /proc/modules, but before actually loading the 
module, it is possible that an rmmod unloads (starts to unload) a 
dependant module. But this does not affect booting.


-- 
pozsy
