Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTABMd5>; Thu, 2 Jan 2003 07:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTABMd5>; Thu, 2 Jan 2003 07:33:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:37071 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261593AbTABMd4>;
	Thu, 2 Jan 2003 07:33:56 -0500
Date: Thu, 2 Jan 2003 12:40:55 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 -- amd-k8-agp.ko needs unknown symbol agp_memory_reserved
Message-ID: <20030102124055.GB26479@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Miles Lane <miles.lane@attbi.com>, linux-kernel@vger.kernel.org
References: <3E13F8FF.7060704@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E13F8FF.7060704@attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 12:31:59AM -0800, Miles Lane wrote:
 > WARNING: /lib/modules/2.5.54/kernel/drivers/char/agp/amd-k8-agp.ko needs 
 > unknown symbol agp_memory_reserved

Gah, that's going to need to be EXPORT_SYMBOL'd. Its in generic.c
which ends up linked to agpgart.ko, so amd-k8-agp.ko doesn't get
to see it.

Whoops.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
