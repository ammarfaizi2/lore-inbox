Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVJ1O5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVJ1O5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVJ1O5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:57:55 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:33293 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030208AbVJ1O5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:57:54 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: X unkillable in R state sometimes on startx ,
 /proc/sysrq-trigger T output attached
References: <5a4c581d0510251335ke8e7ae6n883e0b44a9920ce4@mail.gmail.com>
	<21d7e9970510260325o2a47e6f5gc64d29eec42de086@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: the prosecution rests its case.
Date: Fri, 28 Oct 2005 15:57:41 +0100
In-Reply-To: <21d7e9970510260325o2a47e6f5gc64d29eec42de086@mail.gmail.com> (Dave
 Airlie's message of "26 Oct 2005 11:29:26 +0100")
Message-ID: <87hdb1pu3e.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct 2005, Dave Airlie said:
> Your getting an X hang which is usually a DRM/AGP or X configuartion problems..

Indeed. As a random example, when I installed my new Radeon 9250 last
week, I flipped the AGPMode to 8 because the card said it was capable of
that... and X went CPU-mad within seconds of starting 3D rendering.
Looking at the kernel logs made the cause clear:

Oct 25 22:09:08 hades info: kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode

Whether the cause was that X thought it was using 8x and the kernel
thought it was using 1x, I don't know, but changing it to 4 brought
everything into agreement and eliminated the hangs.

(This was with X.org 6.8.99.901.)


So AGP is indeed one of those things which a misconfiguration of can
cause all sorts of lockup-like problems. (Just like misconfiguring any
of the other buses in the system, I suppose.)

-- 
`"Gun-wielding recluse gunned down by local police" isn't the epitaph
 I want. I am hoping for "Witnesses reported the sound up to two hundred
 kilometers away" or "Last body part finally located".' --- James Nicoll
