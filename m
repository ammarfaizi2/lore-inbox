Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbULHSpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbULHSpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULHSpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:45:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63699 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261313AbULHSoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:44:54 -0500
Date: Wed, 8 Dec 2004 10:44:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] new timeofday core subsystem (v.A1)
In-Reply-To: <1102470997.1281.30.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0412081043031.27324@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
 <1102470997.1281.30.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, john stultz wrote:

> +struct timesource_t {
> +	char* name;
> +	int priority;
> +	enum {
> +		TIMESOURCE_FUNCTION,
> +		TIMESOURCE_MMIO_32,
> +		TIMESOURCE_MMIO_64
> +	} type;
> +	cycle_t (*read_fnct)(void);
> +	void* ptr;
> +	cycle_t mask;
> +	u32 mult;
> +	u32 shift;
> +};

Maybe add TIMESOURCE_CPU or so? How can one specify a time source in a
cpu register?

