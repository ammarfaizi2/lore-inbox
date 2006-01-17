Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWAQJCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWAQJCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 04:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWAQJCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 04:02:06 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:44123 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932354AbWAQJCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 04:02:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YYnLc/wCAAbWBMtXXkBg5XdK01xwm3Y2fK41v+/fpc5QVNem7iuXfqfUTdNMmz1+KNg58xNXc9hQMQ/Z9tyLnD9N1uf2bRJZ4BV8nWevsf+y3imL4JkHtWj6BoGEsxi3XCeTA5+mYIo1dl9hnxoJnPYxD7q/HOhPZ5GFxvx5s6c=  ;
Message-ID: <43CCB262.9070304@yahoo.com.au>
Date: Tue, 17 Jan 2006 20:01:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Magnus Damm <magnus.damm@gmail.com>
CC: Christoph Lameter <clameter@engr.sgi.com>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
References: <20060114155517.GA30543@wotan.suse.de>	 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>	 <20060114181949.GA27382@wotan.suse.de>	 <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>	 <43C9DD98.5000506@yahoo.com.au>	 <Pine.LNX.4.62.0601152251550.17034@schroedinger.engr.sgi.com> <aec7e5c30601170029if0ed895le2c18b26eb7c6a42@mail.gmail.com>
In-Reply-To: <aec7e5c30601170029if0ed895le2c18b26eb7c6a42@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm wrote:
> On 1/16/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> 
>>On Sun, 15 Jan 2006, Nick Piggin wrote:
>>
>>
>>>OK (either way is fine), but you should still drop the __isolate_lru_page
>>>nonsense and revert it like my patch does.
>>
>>Ok with me. Magnus: You needed the __isolate_lru_page for some other
>>purpose. Is that still the case?
> 
> 
> It made sense to have it broken out when it was used twice within
> vmscan.c, but now when the patch changed a lot and the function is
> used only once I guess the best thing is to inline it as Nick
> suggested. I will re-add it myself later on when I need it. Thanks.
> 
> / magnus
> 

I'm curious, what do you need it for?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
