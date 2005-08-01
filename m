Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVHAUAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVHAUAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVHAUAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:00:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60806 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261201AbVHAUAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:00:38 -0400
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
Date: Mon, 01 Aug 2005 16:00:35 -0400
Message-Id: <1122926436.15825.62.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 12:18 -0600, Zwane Mwaikambo wrote:
> On Sat, 30 Jul 2005, Lee Revell wrote:
> 
> > So it looks like artsd wastes way more power DMAing a bunch of silent

> It's already 'fixed' just set artsd to release the sound device after some 
> idle time. It's in the "Auto-Suspend" seection of the KDE sound system 
> control module.

Just to verify that this option works:

1. Using a non hardware mixing device intel8x0, set it to release the
sound device after 5 seconds.

2. In 10 seconds, use aplay or xmms (in ALSA mode, not artsd) to play a
sound.  

3. Then, while the sound is playing, do something that would make KDE
play a sound.

#2 should fail with -EBUSY and you should hear the #3 sound.  If #2
succeeds and #3 fails then KDE is broken IMHO.

Lee

