Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265532AbUAGOGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265539AbUAGOGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:06:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51171 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265532AbUAGOGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:06:44 -0500
Date: Wed, 7 Jan 2004 15:06:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040107140640.GC16720@suse.de>
References: <20040106054859.GA18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040106054859.GA18208@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05 2004, Matt Mackall wrote:
> This is the fourth release of the -tiny kernel tree. The aim of this
> tree is to collect patches that reduce kernel disk and memory
> footprint as well as tools for working on small systems. Target users
> are things like embedded systems, small or legacy desktop folks, and
> handhelds.
> 
> Latest release includes:
>  - various compile fixes for last release
>  - actually include Andi Kleen's bloat-o-meter this time
>  - optional mempool removal

Your CONFIG_MEMPOOL is completely broken as you are no longer giving the
same guarentees (you have no reserve at all). Might as well change it to
CONFIG_DEADLOCK instead.

-- 
Jens Axboe

