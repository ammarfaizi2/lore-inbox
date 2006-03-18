Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWCREw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWCREw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 23:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWCREw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 23:52:27 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:7339 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750712AbWCREw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 23:52:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xbY33bM/Gqh+BRq5QrsFhZ5sXnsxbQ6dEbZNNDxikh+6QP9FZ7jYlcG/S/6gyEftxaVJ6z1L8m0dfku/sG/Rr/hf04zihW9K/Oxa4GXEpqOXRAACdxwgkSALfdhboVhtKtiv/yFdArjHWMwMRtLEffOV50+h5l8OQO6yLW5HW1k=  ;
Message-ID: <441B9205.5010701@yahoo.com.au>
Date: Sat, 18 Mar 2006 15:52:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH][RFC] mm: swsusp shrink_all_memory tweaks
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603181514.27455.kernel@kolivas.org> <441B8F6E.7010802@yahoo.com.au> <200603181546.20794.kernel@kolivas.org>
In-Reply-To: <200603181546.20794.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 18 March 2006 15:41, Nick Piggin wrote:

>>>Index: linux-2.6.16-rc6-mm1/include/linux/swap.h
>>>===================================================================
>>>--- linux-2.6.16-rc6-mm1.orig/include/linux/swap.h	2006-03-18
>>>13:29:38.000000000 +1100 +++
>>>linux-2.6.16-rc6-mm1/include/linux/swap.h	2006-03-18 14:50:11.000000000
>>>+1100 @@ -66,6 +66,51 @@ typedef struct {
>>> 	unsigned long val;
>>> } swp_entry_t;
>>>
>>>+struct scan_control {
>>
>>Why did you put this here? scan_control really can't go outside vmscan.c,
>>it is meant only to ease the passing of lots of parameters, and not as a
>>consistent interface.
> 
> 
> #ifdeffery
> 

Sorry I don't understand...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
