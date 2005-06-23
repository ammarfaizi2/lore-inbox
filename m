Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVFWDJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVFWDJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVFWDJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:09:58 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:26727 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262031AbVFWDJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:09:57 -0400
Message-ID: <42BA26EF.2040807@yahoo.com.au>
Date: Thu, 23 Jun 2005 13:05:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik Van Riel <riel@redhat.com>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, mason@suse.de
Subject: Re: [patch 1/2] vm early reclaim orphaned pages (take 2)
References: <1118978590.5261.4.camel@npiggin-nld.site>  <1119252194.6240.22.camel@npiggin-nld.site> <1119252756.6240.27.camel@npiggin-nld.site> <Pine.LNX.4.61.0506222250250.17731@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0506222250250.17731@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik Van Riel wrote:
> On Mon, 20 Jun 2005, Nick Piggin wrote:
> 
> 
>>+       if (PageLRU(page) && PageActive(page)) {
>>+               list_move(&page->lru, &zone->inactive_list);
>>+               ClearPageActive(page);
>>+       }
> 
> 
> Unless I'm missing something subtle, you might want to
> update zone->nr_active and zone->nr_inactive ...
> 

You're right, thanks very much Rik.

Send instant messages to your online friends http://au.messenger.yahoo.com 
