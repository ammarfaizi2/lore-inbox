Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVADP1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVADP1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVADP1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:27:09 -0500
Received: from [212.20.225.142] ([212.20.225.142]:32282 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261678AbVADP1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:27:05 -0500
Subject: Re: [PATCH] AC97 support for low power codecs
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hekh1grl6.wl@alsa2.suse.de>
References: <1104838450.9143.81.camel@cearnarfon>
	 <s5hekh1grl6.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1104852422.9143.348.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 Jan 2005 15:27:02 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2005 15:27:03.0104 (UTC) FILETIME=[D753DC00:01C4F271]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 15:08, Takashi Iwai wrote:
> 
> Does writing RESET on such a codec must be avoided always?
> Or can one power up again by writing some values on POWER register?
> 

Writing RESET causes an AC97 codec to return to it's default state. On
some codecs this is state is "power down" and therefore undesirable
during a call to probe.

The only way to wake such a codec is via an AC97 warm reset.

Liam
  

