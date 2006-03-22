Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWCVATG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWCVATG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWCVATG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:19:06 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:62287 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751857AbWCVATF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:19:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=z+Ist71o/cakNF5YsmAlFZvrH7W+R7+qgnMqWcwRjG48eBdHoeTJLAFBDK81AZppT/MMiA8wAPwhfaZTjTSp37vRZrMkXVhkWZgQ+m5dvZ7TM/Wi7UXn4zxzHQOEdl7/VNYuNVCRzKM9YglA2ajwRQ+HSPU2/sX+LYcEGfxSjSU=  ;
Message-ID: <442097EE.2000601@yahoo.com.au>
Date: Wed, 22 Mar 2006 11:18:54 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][8/8] mm: lru interface change
References: <bc56f2f0603200538g3d6aa712i@mail.gmail.com>	 <441FF007.6020901@yahoo.com.au> <bc56f2f0603210753k758ebf6dq@mail.gmail.com>
In-Reply-To: <bc56f2f0603210753k758ebf6dq@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
>>I may have missed something very trivial, but... why are they on a
>>list at all if they don't get scanned
> 
> 
> Get the locked pages on a list is necessary for page management,
> scatter the locked pages around isnt a good idea.
> 

This doesn't make sense. Whether or not they're on a list does not
change the fact that they may be "scattered".

> Also, we could add some kinds of scan to the locked pages,
> if we find that it's necessary.
> 

This is a valid reason. But at present you don't scan them, do you?
So you should add them to a list in patch 9 where you add the
machanism to scan them as well, right?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
