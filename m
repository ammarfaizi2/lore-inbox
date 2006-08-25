Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWHYL1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWHYL1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWHYL1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:27:17 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:24446 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750707AbWHYL1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:27:16 -0400
Message-ID: <44EEDF41.1040605@sw.ru>
Date: Fri, 25 Aug 2006 15:30:09 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: devel@openvz.org
CC: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rohit Seth <rohitseth@google.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Devel] [PATCH 1/6] BC: kconfig
References: <44EC31FB.2050002@sw.ru>  <44EC35A3.7070308@sw.ru>	<1156370698.12011.55.camel@localhost.localdomain> <1156371222.2510.715.camel@stark>
In-Reply-To: <1156371222.2510.715.camel@stark>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Wed, 2006-08-23 at 15:04 -0700, Dave Hansen wrote:
> 
>>On Wed, 2006-08-23 at 15:01 +0400, Kirill Korotaev wrote:
>>
>>>--- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
>>>+++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
>>>@@ -432,3 +432,5 @@ source "security/Kconfig"
>>> source "crypto/Kconfig"
>>> 
>>> source "lib/Kconfig"
>>>+
>>>+source "kernel/bc/Kconfig"
>>
>>...
>>
>>>--- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
>>>+++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
>>>@@ -432,3 +432,5 @@ source "security/Kconfig"
>>> source "crypto/Kconfig"
>>> 
>>> source "lib/Kconfig"
>>>+
>>>+source "kernel/bc/Kconfig"
>>
>>Is it just me, or do these patches look a little funky?  Looks like it
>>is trying to patch the same thing into the same file, twice.  Also, the
>>patches look to be -p0 instead of -p1.  
> 
> 
> They do appear to be -p0
it is -p1. patches are generated with gendiff and ./ in names is for -p1

> 	They aren't adding the same thing twice to the same file. This patch
> makes different arches source the same Kconfig.
> 
> 	I seem to recall Chandra suggested that instead of doing it this way it
> would be more appropriate to add the source line to init/Kconfig because
> it's more central and arch-independent. I tend to agree.
agreed. init/Kconfig looks like a good place for including
kernel/bc/Kconfig

Kirill

