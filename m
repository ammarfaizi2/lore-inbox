Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVL2NHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVL2NHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 08:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVL2NHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 08:07:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10969 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750704AbVL2NHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 08:07:01 -0500
Subject: Re: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
From: Arjan van de Ven <arjan@infradead.org>
To: Erez Zilber <erezz@voltaire.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43B3D8D3.30400@voltaire.com>
References: <43B3CA9E.7000804@voltaire.com>
	 <1135857022.2935.19.camel@laptopd505.fenrus.org>
	 <43B3D8D3.30400@voltaire.com>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 14:06:59 +0100
Message-Id: <1135861619.2935.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 14:38 +0200, Erez Zilber wrote:
> Arjan van de Ven wrote:
> 
> >On Thu, 2005-12-29 at 13:38 +0200, Erez Zilber wrote:
> >  
> >
> >>Hi,
> >>
> >>I've downloaded kernel 2.6.15-rc6 (had the same problem with rc7) and 
> >>    
> >>
> >
> >2.6.15-rc needs a newer udev version...
> >
> >
> >  
> >
> 
> Redhat AS4 comes with udev 039. I couldn't find a newer rpm for this distribution, so I cannot replace the current udev rpm.  I've downloaded the latest udev sources from http://www.us.kernel.org/pub/linux/utils/kernel/hotplug/ and installed it but I still get the same errors.

after you get a recent enough udev you probably need to recreate a new
initrd (and pray that you don't need a newer mkinitrd to match the newer
udev...) since udev is also put inside the initrd.

To be fair, enterprise linux distributions aren't actually designed to
run brand spanking new kernels, and the vendors aren't likely to update
userland tools to make newer kernels work either (unlike, say,
distributions like Fedora Core or SuSE or .. or .. or .. )


