Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbVJEWgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbVJEWgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbVJEWgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:36:07 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:58264 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1030408AbVJEWgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:36:05 -0400
X-ORBL: [69.225.172.73]
Subject: Re: [PATCH 2.6.14-rc2 1/2] libata: Marvell spinlock fixes and
	simplification
From: Michael Madore <Michael.Madore@aslab.com>
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Pasi Pirhonen <upi@papat.org>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>,
       scott olson <scotto701@yahoo.com>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>,
       Evgeny Rodichev <er@sai.msu.su>
In-Reply-To: <20051005210842.F366B26369@lns1058.lss.emc.com>
References: <20051005210610.EC31826369@lns1058.lss.emc.com>
	 <20051005210842.F366B26369@lns1058.lss.emc.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 15:35:44 -0700
Message-Id: <1128551744.4041.7.camel@drevil.aslab.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 17:08 -0400, Brett Russ wrote:
> This patch should fix up lockups that people were seeing due to
> improper spinlock placement.  Also, the start/stop DMA routines put
> guarded trust in the cached state of DMA.

Hi Brett,

I assume this patch doesn't address the 'abnormal status 0x80' issue on
the 6081.  On the 5081, I still get two machine checks followed by a
hard lockup when I load the driver.

Mike

