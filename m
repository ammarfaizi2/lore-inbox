Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbTIJInS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264787AbTIJInS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:43:18 -0400
Received: from dp.samba.org ([66.70.73.150]:35489 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264756AbTIJInR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:43:17 -0400
Date: Wed, 10 Sep 2003 18:39:35 +1000
From: Anton Blanchard <anton@samba.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rjwalsh@durables.org
Subject: Re: [PATCH 1/3] netpoll api
Message-ID: <20030910083935.GG1532@krispykreme>
References: <20030910074030.GC4489@waste.org> <20030910004907.67b90bd1.akpm@osdl.org> <20030910081845.GF4489@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910081845.GF4489@waste.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Hmmm, linux/irq.h seemed pretty generic. Maybe those other, silly
> arches can mend their ways?

linux/irq.h:

/*
 * Please do not include this file in generic code.  There is currently
 * no requirement for any architecture to implement anything held
 * within this file.
 *
 * Thanks. --rmk
 */

Generic? Nice try :)

> Ok, looks like m68k, s390, and sparcx are the only ones not using
> irq_desc, and only s390 seems to be far from the irq_desc model. Or I
> could be quite mistaken.

irq_desc will probably die in 2.7, replaced with some helper macros. Its
not a neat fit for many arches (ppc64 included).

Anton
