Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267525AbUGWDnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267525AbUGWDnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 23:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUGWDnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 23:43:11 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:28558 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267525AbUGWDnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 23:43:09 -0400
Message-ID: <41008949.7010400@yahoo.com.au>
Date: Fri, 23 Jul 2004 13:43:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.8-rc1] Prevent excessive scanning of lower zone
References: <20040723014052.69937.qmail@web12826.mail.yahoo.com> <20040722220701.7de4c31f.akpm@osdl.org>
In-Reply-To: <20040722220701.7de4c31f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Shantanu Goel <sgoel01@yahoo.com> wrote:
> 
>>I emailed this a few weeks back to the list but it
>>seems to have gotten lost...
> 

I think your total_reclaimed fix is correct. I sent the same one to Andrew
a while ago, but I'm not sure if he picked it up.

The sc->nr_to_reclaim fix I guess is alright but a bit ugly. Setting
nr_to_reclaim it in try_to_free_pages and balance_pgdat is what I'm doing
now, but that requires teaching balance_pgdat about the lower zone protection
and takes a little more work.
