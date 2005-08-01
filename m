Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVHAPBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVHAPBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVHAPBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:01:25 -0400
Received: from gw.alcove.fr ([81.80.245.157]:59060 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S262203AbVHAPAq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:00:46 -0400
Subject: Re: powerbook power-off and 2.6.13-rc[3,4]
From: Stelian Pop <stelian@popies.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>,
       debian-powerpc@lists.debian.org
In-Reply-To: <1122905228.6881.9.camel@localhost>
References: <1122904460.6491.41.camel@localhost.localdomain>
	 <1122905228.6881.9.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Aug 2005 16:38:56 +0200
Message-Id: <1122907136.31350.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 01 août 2005 à 16:07 +0200, Johannes Berg a écrit :
> On Mon, 2005-08-01 at 15:54 +0200, Antonio-M. Corbi Bellot wrote:
> 
> > Has anyone observed this behaviour (O.S. halt ok but _no_ power-off at
> > the end) with these new '-rc' kernels?
> 
> Yes. I haven't looked for the cause yet though.

I found that if you comment the 
	device_suspend(PMSG_SUSPEND);
line in kernel/sys.c, in the kernel_power_off() function, then it works
again, but I haven't had the time to look further.

I've put LKML in CC: in case this rings someone's bell.
 
Stelian.
-- 
Stelian Pop <stelian@popies.net>

