Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUI0JO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUI0JO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUI0JLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:11:35 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:15820 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S266585AbUI0JKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:10:16 -0400
Date: Mon, 27 Sep 2004 11:10:12 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: Andreas Happe <andreashappe@flatline.ath.cx>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, Andreas Happe <crow@old-fsckful.ath.cx>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
In-Reply-To: <20040927084149.GA3625@final-judgement.ath.cx>
Message-ID: <Pine.LNX.4.53.0409271046280.12238@maxipes.logix.cz>
References: <20040831175449.GA2946@final-judgement.ath.cx>
 <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com>
 <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz>
 <20040907143509.GA30920@old-fsckful.ath.cx> <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz>
 <20040910105502.GA4663@final-judgement.ath.cx> <20040927084149.GA3625@final-judgement.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Andreas Happe wrote:

> Andreas Happe <andreashappe@flatline.ath.cx> [040910 12:55]:
> > [class - based sysfs patch]
>
> hi,
> just wanted to know if there's any feedback regarding this patch. It
> still applies to -rc2 without problems.

I have it compiled in my kernel and ... yes, it works ;-)

One thing that I noticed is that it doesn't complain when loading a second
module for the same cipher. Say that you have both aes.ko and aes-i586.ko.
You load one of them and it is registered for AES algorithm. Then you
modprobe the other one and it doesn't make an error, but the module is not
loaded. I'm not 100% sure that it is a fault in your patch, though. I
haven't tested it with a clean vanilla+your-patch kernel to avoid other
possible culprits.

BTW In http://lists.logix.cz/pipermail/cryptoapi/2004/000088.html I
described a concept of "preferences" that was done for the current
cryptoapi. How to do something similar with your patch applied?

If I'd finally have two or more modules for the same algorithm loaded, how
should the /sys subtree look like?

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
