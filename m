Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbVINRbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbVINRbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVINRbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:31:04 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:10641 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965255AbVINRbC (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:31:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hmrs4raSBqR0vqdVOa7XvzgQtn//9LF8ewJMJ0HVcyZqTeRPxtcPzqrw5b1TLbdw0QKqRY7WUn1KOOCMqPnMS6rMhxej2WeTDXOgAcLaAj/oI0bBEFvsJI1Zyq/DVeIV3Qs7wHsDsQik2au0nvro+KYNsuwMwpUyEk4QpG+l+VE=  ;
Message-ID: <432854B6.1020408@yahoo.com.au>
Date: Thu, 15 Sep 2005 02:49:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5/5] remove HAVE_ARCH_CMPXCHG
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <432838E8.5030302@yahoo.com.au> <432839F1.5020907@yahoo.com.au> <43283B66.8080005@yahoo.com.au> <Pine.LNX.4.61.0509141829050.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509141829050.3743@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Sep 2005, Nick Piggin wrote:
> 
> 
>>Is there any point in keeping this around?
> 
> 
> Yes, for drivers which want to use it to synchronize with userspace.
> Alternatively it could be changed into a Kconfig definition.
> 

I think it already is. At least, I did grep for it and didn't
see anything.

I think userspace synchronization may be quite a valid use of
atomic cmpxchg, but Kconfig is a far better place to do it than
testing HAVE_ARCH_CMPXCHG.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
