Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbUKWEcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbUKWEcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUKVQkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:40:11 -0500
Received: from port-83-236-152-146.static.qsc.de ([83.236.152.146]:50816 "EHLO
	heck.convergence.de") by vger.kernel.org with ESMTP id S262170AbUKVQNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:13:37 -0500
Date: Mon, 22 Nov 2004 17:09:55 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Michael Hunold <hunold@linuxtv.org>,
       linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [linux-dvb-maintainer] [patch] 2.6.10-rc2-mm3: DVB: philips_tdm1316l_config multiple definition
Message-ID: <20041122160955.GA18255@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	Michael Hunold <hunold@linuxtv.org>, linux-kernel@vger.kernel.org,
	linux-dvb-maintainer@linuxtv.org
References: <20041121223929.40e038b2.akpm@osdl.org> <20041122155123.GE19419@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122155123.GE19419@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 04:51:23PM +0100, Adrian Bunk wrote:
> On Sun, Nov 21, 2004 at 10:39:29PM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.10-rc2-mm2:
> >...
> > +dvb-follow-frontend-changes-in-drivers.patch
> >...
> > +dvb-follow-changes-in-dvb-ttpci-and-budget-drivers.patch
> > 
> >  Big DVB update
> >...
> 
> <--  snip  -->
> 
> ...
>   LD      drivers/media/dvb/built-in.o
> drivers/media/dvb/ttusb-budget/built-in.o(.data+0x3364): multiple 
> definition of `philips_tdm1316l_config'
> drivers/media/dvb/ttpci/built-in.o(.data+0x8c8): first defined here
> make[3]: *** [drivers/media/dvb/built-in.o] Error 1
> 
> <--  snip  -->
> 
> 
> Since none of them has a good reason for being global, the patch below 
> makes both static.

Thanks, patch applied to linuxtv.org CVS.

BTW, like I said in some previous mail I think this "Big DVB update"
isn't ready for prime time yet. It breaks support for some
DVB cards (partially fixed in linuxtv.org CVS), so I think
this should not go into the mainline kernel now. IMHO it's better
to wait until 2.6.10 is out.

Michael: Do you think differently?


Johannes
