Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbWHJMky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbWHJMky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161236AbWHJMky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:40:54 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:20817 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161229AbWHJMky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:40:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=MoeA4oBXLtZy1EOLOoISczQRM7nys1vlUCY/oO5mlLyc/cioiHwpUvHCiOawcsM1Envqho+M/WeOJZcME10LnIranybC4e2imMyvCEsVHh2xpOyCm/dTM6Gj2Ios+Qyc444izGmE9lx0YMz3MVY326fudWKq7Ht6qT6gUoDCouw=  ;
Message-ID: <20060810124052.79249.qmail@web25805.mail.ukl.yahoo.com>
Date: Thu, 10 Aug 2006 14:40:52 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : sparsemem usage
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: apw@shadowen.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060810134616.31268991.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> On Wed, 9 Aug 2006 14:19:01 +0000 (GMT)
> moreau francis <francis_moreau2000@yahoo.fr> wrote:
> 
>> Not all arch have page_is_ram(). OK it should be easy to have but we will
>> need create new data structures to keep this info. The point is that it's
>> really easy for memory model such sparsemem to keep this info.
>>
>>> Do you have a usage model in which we really care about the number of
>>> pages in the system to that level of accuracy?
>>>
>> show_mem(), which is arch specific, needs to report them. And some
>> implementations use only pfn_valid().
>>
> 
> BTW, ioresouce information (see kernel/resouce.c)
> 
> [kamezawa@aworks Development]$ cat /proc/iomem | grep RAM
> 00000000-0009fbff : System RAM
> 000a0000-000bffff : Video RAM area
> 00100000-2dfeffff : System RAM
> 
> is not enough ?
> 

well actually you show that to get a really simple information, ie does
a page exist ?, we need to parse some kernel data structures like 
ioresource (which is, IMHO, hackish) or duplicate in each architecture
some data to keep track of existing pages.

Francis
