Return-Path: <linux-kernel-owner+w=401wt.eu-S932306AbXADGvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbXADGvq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 01:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbXADGvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 01:51:46 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:27346 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932306AbXADGvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 01:51:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uqp6W6sEGhjBTgU93CMNX+2HrvvuDDZ5xKtVyIzgiAussYQZuZ+JAQnaskG8xxZIfX6vx70i5c7HeqtP3XIA+JnkspiLdShRl9Jp006NjYZX8XZfLw1Wx23Ub3LV8AJO8lX/Vc/mQpBfrgFH54HOwDpYBSr9ytbBLTAjpuoWuGU=  ;
X-YMail-OSG: eZjZlJ0VM1l606z1qUQBoY5zmQWrtiDjYEmVzlVyVozAVXrOBLR0VBKrihWBqoSIBNQC6s7vrwbxoKYxBr8Y4akcYTpSROAeEN24tnsGlhLgHJoFOhgjqh9Pi4v_5ni8wivKjGnqEbM8QqA-
Message-ID: <459CA3BA.9040806@yahoo.com.au>
Date: Thu, 04 Jan 2007 17:50:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
       akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 6/8] Enable asynchronous wait page and lock page
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20061228084149.GF6971@in.ibm.com> <20061228115510.GA25644@infradead.org> <20061228144717.GA10156@in.ibm.com> <20070102142627.GA14954@infradead.org>
In-Reply-To: <20070102142627.GA14954@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Dec 28, 2006 at 08:17:17PM +0530, Suparna Bhattacharya wrote:
> 
>>I am really bad with names :(  I tried using the _wq suffixes earlier and
>>that seemed confusing to some, but if no one else objects I'm happy to use
>>that. I thought aio_lock_page() might be misleading because it is
>>synchronous if a regular wait queue entry is passed in, but again it may not
>>be too bad.
>>
>>What's your preference ? Does anything more intuitive come to mind ?
> 
> 
> Beein bad about naming seems to be a disease, at least I suffer from it
> aswell.  I wouldn't mind either the _wq or aio_ naming - _wq describes
> the way it's called and aio_ describes it's a special case for aio.
> Similarly to how ->aio_read/->aio_write can be used for synchronous I/O
> aswell.

What about lock_page_async? A synchronous lock_page is the normal case,
and for that guy it makes no sense to explicitly pass in a waitqueue, so
it kind of falls into place?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
