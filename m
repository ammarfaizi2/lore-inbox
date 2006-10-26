Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423697AbWJZXGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423697AbWJZXGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423718AbWJZXGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:06:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:24710 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1423697AbWJZXGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:06:49 -0400
Date: Fri, 27 Oct 2006 01:06:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2 and very unstable NTP
In-Reply-To: <1161899986.960.59.camel@localhost>
Message-ID: <Pine.LNX.4.64.0610270048470.6761@scrub.home>
References: <20061026123051.3831.qmail@science.horizon.com>
 <1161899986.960.59.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Oct 2006, john stultz wrote:

> One of the recent changes was removing the in-kernel PPS code. This was
> done because there were no in-kernel users of the interface (the only
> ones being I believe in a variant of this LinuxPPS patch). While from
> the diffstat below it doesn't look like the patch affects the
> timekeeping code, it would be good to first reproduce the issue without
> the patch.

The recent patch by Jim Houston explains the misbehaviour. It seems the 
ntp daemon uses ADJ_OFFSET_SINGLESHOT for time adjustments, which is 
rather coarse-grained. By adding proper PPS support one should be able to 
get a more stable clock, but it's better done by someone who has the 
hardware to test this.

bye, Roman
