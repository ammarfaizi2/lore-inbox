Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161491AbWAMIaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161491AbWAMIaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161492AbWAMIaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:30:16 -0500
Received: from 203-79-122-66.cable.paradise.net.nz ([203.79.122.66]:9819 "EHLO
	kereru.site") by vger.kernel.org with ESMTP id S1161491AbWAMIaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:30:14 -0500
Date: Fri, 13 Jan 2006 21:30:09 +1300
From: Volker Kuhlmann <list0570@paradise.net.nz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd turning off DMA when verifying DVD-R
Message-ID: <20060113083009.GE12338@paradise.net.nz>
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it> <43C72F41.5060207@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C72F41.5060207@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13 Jan 2006 17:40:33 NZDT +1300, Robert Hancock wrote:

> I'm thinking the IDE code is too aggressive in assuming that the failure 
>  is because of a DMA problem and disabling it.. Most likely all that's 
> happening is the drive is taking a long time to complete the current 
> command.

Yes! Each time when inserting a faulty CD/DVD, or whenever the drive
gives read errors for whatever reason, the kernel decides to turn DMA
off and try again, fail (again) and leave DMA off. And this after having
successfully used DMA before - so it's not that the device is
DMA-incapable.

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.
