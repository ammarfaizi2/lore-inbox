Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWH1Hby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWH1Hby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWH1Hby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:31:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55994 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932423AbWH1Hbx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:31:53 -0400
Message-ID: <44F29BCD.3080408@zytor.com>
Date: Mon, 28 Aug 2006 00:31:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com, Matt_Domsch@dell.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com>
In-Reply-To: <44F2902B.5050304@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> 
> Better patch.
> I've noticed that this code sets esi but then reference using si... So 
> fixed to
> use esi (It worked so far since we are in low area... But I think using 
> the same
> register type is cleaner...)
> 

Totally pointless since we're in 16-bit mode (as is the "incl %esi")... 
I guess it's "better" in the sense that if we run out of that we'll 
crash due to a segment overrun... maybe (some BIOSes leave us 
unknowningly in big real mode...)

	-hpa
