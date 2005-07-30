Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263096AbVG3Sfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbVG3Sfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVG3Sfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:35:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49829 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263096AbVG3Sfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:35:41 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507301216370.29844@montezuma.fsmlabs.com>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
	 <1122678943.9381.44.camel@mindpipe>
	 <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
	 <1122746718.14769.4.camel@mindpipe>
	 <Pine.LNX.4.61.0507301216370.29844@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 14:35:39 -0400
Message-Id: <1122748540.14769.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 12:18 -0600, Zwane Mwaikambo wrote:
> On Sat, 30 Jul 2005, Lee Revell wrote:
> 
> > So it looks like artsd wastes way more power DMAing a bunch of silent
> > pages to the sound card than HZ=1000.
> > 
> > There's nothing the ALSA layer can do about this, it's a KDE bug.
> > 
> > I think this is a good argument for leaving HZ at 1000 until some of
> > these userspace bugs are fixed.
> 
> It's already 'fixed' just set artsd to release the sound device after some 
> idle time. It's in the "Auto-Suspend" seection of the KDE sound system 
> control module.

I suspect that the failure to enable this by default is a relic of the
pre-dmix era, when access to the sound device was exclusive, to prevent
another app from grabbing it in the interim.

Of course this behavior is completely unnecessary with ALSA 1.0.9 or
later, as the default PCM uses dmix so the above scenario would not
block the sound card.

Anyway, KDE does not need to release the sound device to prevent this.
Simply stopping the PCM should be enough.

Lee

