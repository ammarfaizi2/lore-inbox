Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVFZTv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVFZTv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFZTv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:51:56 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:54922 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261566AbVFZTvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:51:53 -0400
Message-ID: <42BF074D.6020305@ens-lyon.org>
Date: Sun, 26 Jun 2005 21:51:41 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
References: <20050626040329.3849cf68.akpm@osdl.org>
In-Reply-To: <20050626040329.3849cf68.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26.06.2005 13:03, Andrew Morton a écrit :
> - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
>   the recent PCI breakage sorted out.

Hi Andrew,

> +alsa-maestro3-div-by-zero-fix.patch
> 
>  Revert an alsa change which appears to cause a divide-by-zero.

I think you can now drop this one.
My "divide error" does not appear in -mm2.
It seems that it is fixed by the following patch:

> +revert-gregkh-pci-pci-assign-unassigned-resources.patch
> 
>  Revert a bad patch in it

To summarize, everything seems to now work fine on my Compaq Evo
N600c laptop. Both breakages I was seeing in -mm1 are now fixed:
* the maestro3 divide error does not appear anymore
* I reported a few days ago that my yenta hang was fixed
by pci-yenta-cardbus-fix.patch

Thanks,
Brice
