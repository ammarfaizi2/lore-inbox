Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbTEWTp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTEWTp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 15:45:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59147 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264157AbTEWTpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 15:45:25 -0400
Date: Fri, 23 May 2003 21:57:57 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030523195757.GA27557@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030509145738.GB17581@alpha.home.local> <20030512110218.4bbc1afe.skraw@ithnet.com> <20030523123837.6521738f.skraw@ithnet.com> <428570000.1053694721@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428570000.1053694721@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

On Fri, May 23, 2003 at 06:58:41AM -0600, Justin T. Gibbs wrote:
> > Ok. I managed to crash the tested machine after 14 days now. The crash itself
> > is exactly like former 2.4.21-X. It just freezes, no oops no nothing. It looks
> > like things got better, but not solved.
> 
> What is telling you that the freeze is SCSI related?  Are you running
> with the nmi watchdog and have a trace?  Do you have driver messages
> that you aren't sharing?

Stephen,

Justin is right, you should run it through the NMI watchdog, in the hope to
find something useful. If it hangs again in 14 days, you won't know why and
that may be frustrating. With the NMI watchdog, you at least have a chance to
see where it locks up, and you may find it to be within the driver, which would
help Justin stabilize it, or within any other kernel subsystem.

I had to use nmi_watchdog=2 at boot time, but other people use 1.

Regards,
Willy

