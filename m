Return-Path: <linux-kernel-owner+w=401wt.eu-S1750780AbXAHXzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbXAHXzZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXAHXzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:55:24 -0500
Received: from terminus.zytor.com ([192.83.249.54]:55644 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbXAHXzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:55:24 -0500
Message-ID: <45A2D9C8.9020007@zytor.com>
Date: Mon, 08 Jan 2007 15:54:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: dean gaudet <dean@arctic.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All Transmeta CPUs have constant TSCs
References: <200701050148.l051mHGM005275@terminus.zytor.com> <Pine.LNX.4.61.0701051524440.7813@yvahk01.tjqt.qr> <Pine.LNX.4.64.0701072358010.26307@twinlark.arctic.org> <Pine.LNX.4.61.0701082118370.23737@yvahk01.tjqt.qr> <45A2AEE0.4090707@zytor.com> <Pine.LNX.4.64.0701081506330.12282@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.64.0701081506330.12282@twinlark.arctic.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> On Mon, 8 Jan 2007, H. Peter Anvin wrote:
> 
>> I *definitely* support the concept that RDPMC 0 should could CPU cycles by
>> convention in Linux.
> 
> unfortunately that'd be very limiting and annoying on core2 processors 
> which have dedicated perf counters for clocks unhalted (actual vs. 
> nominal), but only 2 configurable perf counters.  i forget what ecx value 
> gets you the dedicated counters... but a solution which might work would 
> be a syscall to return the perf counter number...
> 
> or we could just merge perfmon ;)
> 

OK, if there are dedicated counters in hardware at a different number, 
we probably should make it an ELF entry value (no need to make it a 
syscall for a constant.)

	-hpa
