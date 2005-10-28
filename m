Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbVJ1LHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVJ1LHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 07:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVJ1LHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 07:07:10 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:11120 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965208AbVJ1LHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 07:07:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=m6Rqv4zI38UHH6IbvvQRZbMob7LQjPONfOyEerW6fMp1C1I5EMORmsk64JripJyUQVT+iGiUqZx4fqhQxIwfJM7KuRZaZYk0yLv1QiousVjBcn9eSaQe+C0g0xRJmm6JIP261fE5MYWNbBvtuDjaZnZtTMAU0QB85HMHO6G53eE=  ;
Message-ID: <43620650.4090903@yahoo.com.au>
Date: Fri, 28 Oct 2005 21:06:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: ntl@pobox.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] big reader semaphore take#2
References: <20051028104437.GA17461@htj.dyndns.org>
In-Reply-To: <20051028104437.GA17461@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  Hello guys,
> 
> This is the second take of brsem (big reader semaphore).
> 
> Nick, unfortunately, simple array of rwsem's does not work as lock
> holders are not pinned down to cpus and may release locks on other
> cpus.
> 

That's right. It would require down_read to return the index
or a pointer to the lock that it took, and to pass that into
up_read. So it wouldn't be a completely drop-in replacement
for a regular semaphore if that's what you had in mind?

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
