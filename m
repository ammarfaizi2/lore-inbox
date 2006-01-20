Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWATLzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWATLzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWATLzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:55:03 -0500
Received: from mra02.ch.as12513.net ([82.153.252.24]:20933 "EHLO
	mra02.ch.as12513.net") by vger.kernel.org with ESMTP
	id S1750761AbWATLzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:55:01 -0500
Date: Fri, 20 Jan 2006 11:54:43 +0000
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: Adrian Bunk <bunk@stusta.de>, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different approach
Message-ID: <20060120115443.GA16582@palantir8>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20060119174600.GT19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119174600.GT19398@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me we can already get rid of sound/oss/dmasound now.
I cannot find anything refering to it anymore, and the ALSA powermac
driver is being maintained.

Martin

On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:
> My proposal to remove OSS drivers where ALSA drivers for the same 
> hardware exists had two reasons:
> 
> 1. remove obsolete and mostly unmaintained code
> 2. get bugs in the ALSA drivers reported that weren't previously
>    reported due to the possible workaround of using the OSS drivers
> 
> I'm slowly getting more and more reports for the second case.
> 
> 
> The list below divides the OSS drivers into the following three 
> categories:
> 1. ALSA drivers for the same hardware
> 2. ALSA drivers for the same hardware with known problems
> 3. no ALSA drivers for the same hardware
> 
> 
> My proposed timeline is:
> - shortly before 2.6.16 is released:
>   adjust OBSOLETE_OSS_DRIVER dependencies to match exactly the
>   drivers under 1.
> - from the release of 2.6.16 till the release of 2.6.17:
>   approx. two months for users to report problems with the ALSA
>   drivers for the same hardware
> - after the release of 2.6.17 (and before 2.6.18):
>   remove the subset of drivers marked at OBSOLETE_OSS_DRIVER without
>   known regressions in the ALSA drivers for the same hardware
> 
> 
> To make a long story short:
> 
> If you are using an OSS driver because the ALSA driver doesn't work 
> equally well on your hardware, send me an email with a bug number in the 
> ALSA bug tracking system now.
