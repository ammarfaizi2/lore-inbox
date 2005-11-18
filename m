Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVKRT5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVKRT5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKRT5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:57:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932362AbVKRT5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:57:04 -0500
Date: Fri, 18 Nov 2005 11:56:57 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
Message-ID: <20051118195657.GI7991@shell0.pdx.osdl.net>
References: <437E2C69.4000708@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437E2C69.4000708@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Dobson (colpatch@us.ibm.com) wrote:
> /proc/sys/vm/critical_pages: write the number of pages you want to reserve
> for the critical pool into this file

How do you size this pool?  Allocations are interrupt driven, so how to you
ensure you're allocating for the cluster network traffic you care about?

> /proc/sys/vm/in_emergency: write a non-zero value to tell the kernel that
> the system is in an emergency state and authorize the kernel to dip into
> the critical pool to satisfy critical allocations.

Seems odd to me.  Why make this another knob?  How did you run to set this
flag if you're in emergency and kswapd is going nuts?

thanks,
-chris
