Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWBMXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWBMXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWBMXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:42:57 -0500
Received: from ns1.suse.de ([195.135.220.2]:27820 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964855AbWBMXm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:42:56 -0500
Date: Tue, 14 Feb 2006 00:42:54 +0100
From: Olaf Hering <olh@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hannes Reinecke <hare@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060213234254.GA5368@suse.de>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com> <20060213104645.GA17173@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060213104645.GA17173@elte.hu>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Feb 13, Ingo Molnar wrote:

> 
> * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > The boot sequence on s390 sometimes takes ages and we spend a very 
> > long time (up to one or two minutes) in calibrate_migration_costs. The 
> > time spent there differs from boot to boot. Also the calculated costs 
> > differ a lot. I've seen differences by up to a factor of 15 (yes, 
> > factor not percent). Also I doubt that making these measurements make 
> > much sense on a completely virtualized architecture where you cannot 
> > tell how much cpu time you will get anyway. Is there any workaround or 
> > fix available so we can avoid seeing this?
> 
> which is the precise kernel version used? We toned down calibration a 
> bit recently.

We did a bit of testing, -rc2-git3 + the patch below was still ok.

 [PATCH] s390: earlier initialization of cpu_possible_map
 9733e2407ad2237867cb13c04e7d619397fa3090

