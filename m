Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWFTTCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWFTTCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWFTTCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:02:06 -0400
Received: from outbound-res.frontbridge.com ([63.161.60.49]:32704 "EHLO
	outbound2-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750707AbWFTTCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:02:05 -0400
X-BigFish: V
Message-ID: <449845B8.6090401@am.sony.com>
Date: Tue, 20 Jun 2006 12:00:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
CC: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, paulus@samba.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [Cbe-oss-dev] [patch 01/20] cell: add RAS support
References: <20060620175007.GE4845@pb15.lixom.net>
In-Reply-To: <20060620175007.GE4845@pb15.lixom.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jun 2006 19:00:08.0353 (UTC) FILETIME=[BFB10910:01C6949B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:
> On Tue, Jun 20, 2006 at 06:26:53PM +0200, Arnd Bergmann wrote:
>> On Tuesday 20 June 2006 17:43, Olof Johansson wrote:
>> > 
>> > > This is a first version of support for the Cell BE "Reliability,
>> > > Availability and Serviceability" features.
>> > 
>> > Does it really make sense to do this under a config option? I don't
> see
>> > why anyone would not want to know that their machine is about to
> melt.
>> > 
>> You can only have that when running on bare metal. Machines that run
>> on a hypervisor can't run that code.
> 
> Well, it's harmless to build it in even on hypervisor systems, right?


Harmless if you have a lot of RAM...


>> It probably makes sense to auto-select that option for
> CONFIG_CELL_BLADE
>> though.
> 
> Sounds like a reasonable trade-off.


If its always built in, then I guess we don't need the conditionals
in cell/setup.c:

+#ifdef CONFIG_CBE_RAS
+	cbe_ras_init();
+#endif


-Geoff

