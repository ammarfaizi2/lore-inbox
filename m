Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVASBTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVASBTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 20:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVASBTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 20:19:52 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:44504 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261518AbVASBTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 20:19:50 -0500
Date: Tue, 18 Jan 2005 20:19:50 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] consolidate arch specific resource.h headers
Message-ID: <20050119011950.GA15685@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
References: <20050118161056.H469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118161056.H469@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 04:10:56PM -0800, Chris Wright wrote:
> +#define INIT_RLIMITS					\
> +{							\
> +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> +	{      _STK_LIM, _STK_LIM_MAX  },		\
> +	{             0, RLIM_INFINITY },		\
> +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> +	{             0,             0 },		\
> +	{      INR_OPEN,     INR_OPEN  },		\
> +	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
> +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> +	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
> +	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
> +}

While you are rooting around in there, perhaps this block
should be converted to C99 initializer syntax, to avoid
problems if arch-specific changes are later introduced?

Regards,

	Bill Rugolsky
