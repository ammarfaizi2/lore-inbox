Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753421AbWKFRDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbWKFRDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbWKFRDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:03:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:14767 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753421AbWKFRDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:03:46 -0500
From: Andi Kleen <ak@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] double fault in 2.6.19rc4-git5 =?iso-8859-1?q?while=09unplugging/replugging_a_USB?= headset
Date: Mon, 6 Nov 2006 18:03:42 +0100
User-Agent: KMail/1.9.5
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <200611060220.07024.ak@suse.de> <s5h4ptchdvz.wl%tiwai@suse.de>
In-Reply-To: <s5h4ptchdvz.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061803.42297.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> How did it happen?  You plugged out a usb adaptor during xmms is
> running with OSS output mode?

xmms was running yes. But I think the oops happened on replug.

Long story: i had the headset connected during boot and my XMMS
insisted on outputing its music on it, which wasn't intended -- 
i wanted it on the speakers connected to the motherboard sound chip.

So i unplug the headset and restarted alsa initialization,
but it was very unhappy about cleaning up and couldn't initialize
the other sound card. I replugged the headset and then
I got the oops.

-Andi

