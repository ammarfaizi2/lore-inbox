Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267996AbTBMJe1>; Thu, 13 Feb 2003 04:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbTBMJe1>; Thu, 13 Feb 2003 04:34:27 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:12184 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267996AbTBMJe0>;
	Thu, 13 Feb 2003 04:34:26 -0500
Date: Thu, 13 Feb 2003 09:39:51 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH] cpufreq: move frequency table helpers to extra module
Message-ID: <20030213093951.GA22151@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
	davej@suse.de, linux-kernel@vger.kernel.org,
	cpufreq@www.linux.org.uk
References: <20030213091131.GA8909@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213091131.GA8909@brodo.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 10:11:31AM +0100, Dominik Brodowski wrote:
 > The CPU frequency table helpers can easily be modularized --
 > especially as they are not needed on all architectures, or for 
 > all drivers.

As most of the x86 drivers have been converted now, it looks like
it'd make more sense to conditionalise this on architecture, and
move the remaining x86 drivers over to the helpers (longrun/longhaul).

It just strikes me as silly that we have a config option that when
disabled could end up showing no chip drivers when the conversion
is complete.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
