Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWGNVCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWGNVCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161301AbWGNVCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 17:02:06 -0400
Received: from deeprooted.net ([216.254.16.51]:32693 "EHLO paris.internal.net")
	by vger.kernel.org with ESMTP id S1161126AbWGNVCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 17:02:05 -0400
Subject: Re: [PATCH] 2.6.17-rt add clockevent to ixp4xx
From: Kevin Hilman <khilman@deeprooted.net>
To: Milan Svoboda <msvoboda@ra.rockwell.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF17E03102.B88C1774-ONC12571AB.003987F5-C12571AB.003A4830@ra.rockwell.com>
References: <OF17E03102.B88C1774-ONC12571AB.003987F5-C12571AB.003A4830@ra.rockwell.com>
Content-Type: text/plain
Organization: Deep Root Systems
Date: Fri, 14 Jul 2006 16:02:04 -0500
Message-Id: <1152910924.16702.34.camel@vence.internal.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 12:36 +0200, Milan Svoboda wrote:

> I did patch against -hrt-dyntick (see lkml, this thread) wich is almost 
> the same
> as this one against -rt (for ixp4xx part only) and I found that when timer 
> is
> loaded with IXP4XX_OST_ONE_SHOT the latency time suddenly drops to ~30usec instead
> of ~2000usec! I'd like know what's the reason for this...

You should implement the set_mode method as well and set the
IXP4XX_OST_ONE_SHOT when the clockevent layer mode == CLOCK_EVT_ONESHOT.

Kevin



