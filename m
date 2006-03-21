Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWCUW5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWCUW5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWCUW5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:57:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9667 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964883AbWCUW5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:57:47 -0500
Date: Tue, 21 Mar 2006 14:57:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2: Why is CONFIG_MIGRATION available for everyone?
In-Reply-To: <20060321225430.GJ3890@stusta.de>
Message-ID: <Pine.LNX.4.64.0603211455430.14145@schroedinger.engr.sgi.com>
References: <20060318044056.350a2931.akpm@osdl.org> <20060321225430.GJ3890@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Adrian Bunk wrote:

> 5. Make it possible to configure NUMA systems without page migration
>    and non-NUMA systems with page migration.
> 
> 
> I don't see the point in making this option visible for the majority of 
> users on non-NUMA systems who will never need it.
> 
> When is it required on non-NUMA systems?
> Memory hotplug?

That is one. It also may be useful for transferring pages between various 
zones. Could be used to free up space in ZONE_DMA etc. Right now none of 
these uses exist so we could disable it by default for now?
