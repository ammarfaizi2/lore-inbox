Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVCHGNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVCHGNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVCHGMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:12:25 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:42414 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261598AbVCHGJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:09:57 -0500
Message-ID: <422D42BF.4060506@jp.fujitsu.com>
Date: Tue, 08 Mar 2005 15:14:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH] 2/2 Prezeroing large blocks of pages during allocation
 Version 4
References: <20050307194021.E6A86E594@skynet.csn.ul.ie>
In-Reply-To: <20050307194021.E6A86E594@skynet.csn.ul.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mel Gorman wrote:

>+#define BITS_PER_ALLOC_TYPE 5
> #define ALLOC_KERNNORCLM 0
> #define ALLOC_KERNRCLM 1
> #define ALLOC_USERRCLM 2
> #define ALLOC_FALLBACK 3
>+#define ALLOC_USERZERO 4
>+#define ALLOC_KERNZERO 5
>

Now, 5bits per  MAX_ORDER pages.
I think it is simpler to use "char[]" for representing type of  memory 
alloc type than bitmap.

Thanks
-- Kame <kamezawa.hiroyu@jp.fujitsu.com>


