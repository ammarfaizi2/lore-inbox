Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVHRNcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVHRNcG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVHRNcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:32:06 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:45026 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932223AbVHRNcF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:32:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Martin =?utf-8?q?MOKREJ=C5=A0?= <mmokrejs@ribosome.natur.cuni.cz>
Subject: Re: openafs is really faster on linux-2.4. than 2.6
Date: Thu, 18 Aug 2005 23:31:55 +1000
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <43032109.6030709@ribosome.natur.cuni.cz> <200508182257.35544.kernel@kolivas.org> <43048D81.80402@ribosome.natur.cuni.cz>
In-Reply-To: <43048D81.80402@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508182331.56217.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005 23:30, Martin MOKREJŠ wrote:
> But that is very short and does not affect the interpretation here.

Crap. The sync can take ages.

> The throughput is clearly lower on 2.6 kernel and definitely the
> CPU is in my eyes unnecessarily blocked... Why is the CPU in the
> wait state instead of idle (this is teh problem on 2.6 series
> but CPU is free on 2.4 series)? That's the main problem I think at the
> moment.

There is no wait state accounted for in 2.4 so you won't see it.

Con

> Con Kolivas wrote:
> > On Thu, 18 Aug 2005 22:48, Martin MOKREJŠ wrote:
> >>I think the problem here is outside afs.
> >>Just doing this dd test but writing data directly to the ext2
> >>target gives same behaviour, i.e. on 2.4 kernel I see most of the
> >>CPU idle but on 2.6 kernel all that CPU amount is shown as in
> >>wait state. And the numbers from 2.4 kernel show higher throughput
> >>compared to the 2.6 kernel (regardless the the PREEMPT or no PREEMPT
> >>was used).
> >
> > Don't forget to include sync time.
