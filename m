Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWATRcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWATRcU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWATRcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:32:20 -0500
Received: from c-67-174-241-67.hsd1.ca.comcast.net ([67.174.241.67]:6799 "EHLO
	plato.virtuousgeek.org") by vger.kernel.org with ESMTP
	id S1751112AbWATRcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:32:17 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jack Steiner <steiner@sgi.com>
Subject: Re: [PATCH] SN2 user-MMIO CPU migration
Date: Fri, 20 Jan 2006 09:31:58 -0800
User-Agent: KMail/1.9
Cc: Brent Casavant <bcasavan@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, jes@sgi.com, tony.luck@intel.com
References: <20060118163305.Y42462@chenjesu.americas.sgi.com> <200601191818.43157.jbarnes@virtuousgeek.org> <20060120132650.GA4272@sgi.com>
In-Reply-To: <20060120132650.GA4272@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601200931.58281.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 20, 2006 5:26 am, Jack Steiner wrote:
> I don't think calling mmiob() directly would work. In order to make
> CONFIG_IA64_GENERIC work, the call to mmiob() needs to be underneath a
> platform vector. Using ia64_platform_is() would also work but I think
> a platform vector is cleaner.

mmiowb is already a platform vector on ia64, so I think you're ok there.

> A second reason for an arch_task_migrate() instead of a specific
> mmiob() is to provide a hook for a future platform that require
> additional work to be done when a task migrates.

What does the new platform require (just curious)?

Jesse
