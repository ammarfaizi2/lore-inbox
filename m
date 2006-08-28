Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWH1Ud1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWH1Ud1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWH1Ud1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:33:27 -0400
Received: from terminus.zytor.com ([192.83.249.54]:10117 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751496AbWH1Ud0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:33:26 -0400
Message-ID: <44F35304.7010807@zytor.com>
Date: Mon, 28 Aug 2006 13:33:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Alon Bar-Lev <alon.barlev@gmail.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com> <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com> <44F335C8.7020108@zytor.com> <20060828184637.GD13464@lists.us.dell.com> <44F33D55.4080704@zytor.com> <20060828201223.GE13464@lists.us.dell.com>
In-Reply-To: <20060828201223.GE13464@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> On Mon, Aug 28, 2006 at 12:00:37PM -0700, H. Peter Anvin wrote:
>> Matt Domsch wrote:
>>> No reason.  I was just trying to be careful, not leaving data in the
>>> upper bits of those registers going uninitialized.  If we know they're
>>> not being used ever, then it's not a problem.  But I don't think
>>> that's the source of the command line size concern, is it?
>>>
>> No, it's treating the command line as a fixed buffer, as opposed to a 
>> null-terminated string.  This was always a bug, by the way.
> 
> OK, I'll look at fixing that, and using %esi throughout.
> 

NAK on that.  "Using %esi throughout" is a red herring, and just will 
produce worse code for no gain.

	-hpa
