Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVLUXT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVLUXT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbVLUXT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:19:56 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:57536 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964952AbVLUXTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:19:55 -0500
Subject: Re: remove CONFIG_UID16
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: 7eggert@gmx.de, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512212332450.605@yvahk01.tjqt.qr>
References: <5kCbe-45z-7@gated-at.bofh.it>  <E1EnZIZ-0003Px-3c@be1.lrz>
	 <1134844168.11227.3.camel@mindpipe>
	 <Pine.LNX.4.61.0512212332450.605@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 18:23:43 -0500
Message-Id: <1135207424.31433.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 23:33 +0100, Jan Engelhardt wrote:
> >> > It seems noone noticed that CONFIG_UID16 was accidentially always
> >> > disabled in the latest -mm kernels.
> >> > 
> >> > Is there any reason against removing it completely?
> >> 
> >> Maybe embedded systems.
> >
> >The comments in the code say it's for backwards compatibility:
> >
> >(from include/linux/highuid.h)
> >
> > *
> > * CONFIG_UID16 is defined if the given architecture needs to
> > * support backwards compatibility for old system calls.
> > *
> >
> >This implies that removing it would break some applications, right?
> 
> 
> So what are the most recent apps that still use them, and for what kernel 
> were they originally designed?

I don't think this is a productive line of reasoning, even if we could
not identify one such app.  We should not break user visible APIs
without a compelling reason.

Lee

