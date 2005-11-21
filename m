Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVKUFv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVKUFv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 00:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVKUFv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 00:51:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:36833 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932200AbVKUFv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 00:51:28 -0500
Message-ID: <4381605F.3040300@us.ibm.com>
Date: Sun, 20 Nov 2005 21:51:27 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 2/8] Create emergency trigger
References: <437E2C69.4000708@us.ibm.com>	<437E2D57.9050304@us.ibm.com> <20051118162112.7bf21df5.pj@sgi.com>
In-Reply-To: <20051118162112.7bf21df5.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>@@ -876,6 +879,16 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
>> 	int can_try_harder;
>> 	int did_some_progress;
>> 
>>+	if (is_emergency_alloc(gfp_mask)) {
> 
> 
> Can this check for is_emergency_alloc be moved lower in __alloc_pages?
> 
> I don't see any reason why most __alloc_pages() calls, that succeed
> easily in the first loop over the zonelist, have to make this check.
> This would save one conditional test and jump on the most heavily
> used code path in __alloc_pages().

Good point, Paul.  Will make sure that gets moved.

Thanks!

-Matt
