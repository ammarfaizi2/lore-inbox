Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSLBSQy>; Mon, 2 Dec 2002 13:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSLBSQy>; Mon, 2 Dec 2002 13:16:54 -0500
Received: from magic.adaptec.com ([208.236.45.80]:3275 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id <S264690AbSLBSQx>;
	Mon, 2 Dec 2002 13:16:53 -0500
Date: Mon, 02 Dec 2002 11:24:13 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: AIC79xx driver question
Message-ID: <36490000.1038853452@aslan.btc.adaptec.com>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470580D41F@hdsmsx103.hd.intel.com>
References: <A5974D8E5F98D511BB910002A50A66470580D41F@hdsmsx103.hd.intel.com
 >
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Justin,
> 
> I was looking at the code for aic79xx, and it appears that the channel is
> hard-coded to 'A' in a number of places, rather than using
> SCB_GET_CHANNEL() (e.g.: calls to ahd_reset_channel in aic79xx_core.c).
> Was this intentional?  Is there only one channel per aic79xx host? 

Yes.  There is only one channel.  Much of the code was ported from
the aic7xxx driver which, due to the aic7770's twin/narrow capability,
must have a concept of "channel".  At some point, the channel references
may be completely removed from the code, but they are harmless.

--
Justin
