Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWFLRwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWFLRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWFLRwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:52:25 -0400
Received: from terminus.zytor.com ([192.83.249.54]:37835 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751069AbWFLRwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:52:24 -0400
Message-ID: <448DA9CF.9090504@zytor.com>
Date: Mon, 12 Jun 2006 10:52:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 built-in command line
References: <20060611215530.GH24227@waste.org> <e6k7ak$gpd$1@terminus.zytor.com> <200606121936.35042.mb@bu3sch.de>
In-Reply-To: <200606121936.35042.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
>>
>> a. Please make the patch available for x86-64 as well as x86.  The two
>> are coupled enough that they need to agree.
>>
>> b. This patch will override a user-provided command line if one
>> exists.  This is the wrong behaviour; instead, the builtin command
>> line should only apply if no user-specified command line is present.
> 
> I would say a user supplied cmd line should be appended to the
> built-in cmd line.
> 

That's another option; going with the "later wins" rule.  However, there is a problem with 
this, and that is that the total length can end up being very long.

	-hpa
