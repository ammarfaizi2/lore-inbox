Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVIUJmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVIUJmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVIUJmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:42:20 -0400
Received: from oban.houtzager.net ([217.77.130.26]:60073 "EHLO
	oban.houtzager.net") by vger.kernel.org with ESMTP id S1750797AbVIUJmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:42:19 -0400
Subject: Re: OOPS in raid10.c:1448 in vanilla 2.6.13.2
From: Guus Houtzager <guus@luna.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <17201.6713.60861.781073@cse.unsw.edu.au>
References: <1127234670.2893.103.camel@localhost>
	 <17201.6713.60861.781073@cse.unsw.edu.au>
Content-Type: text/plain
Organization: Luna.nl BV
Date: Wed, 21 Sep 2005 11:42:06 +0200
Message-Id: <1127295726.5136.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all: thanks for the speedy reply! Both patches applied cleanly
to 2.6.13.2 and work as expected. No more oops :) I hope these patches
make it into the next stable release of the 2.6.13 branch.

On Wed, 2005-09-21 at 10:30 +0200, Neil Brown wrote:

<snip>

> > Filesystem on /mnt stays usable during all this (slight hickup when a
> > disk is removed, but keeps going)
> > Then reinserted sdc. To get it resynced I did:
> > # mdadm /dev/md1 -r /dev/sdc2
> > # mdadm /dev/md1 -a /dev/sdc2
> > And it happily resynced and made sdc2 healthy again.
> 
> now
>    sda2 sdc2 missing sdd2
> 
> note that sdc2 took the first empty slot.

That's where I went wrong. I thought it would take it's "old" place
again at the second empty slot.

<snip the rest>

Thanks again!

Regards,

Guus Houtzager
-- 
                              Luna.nl B.V.
                Puntegaalstraat 109 * 3024 EB Rotterdam
              T 010 7502000 * F 010 7502002 * www.luna.nl



