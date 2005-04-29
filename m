Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVD2GqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVD2GqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 02:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVD2GqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 02:46:01 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:28861 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262442AbVD2Gpo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 02:45:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RcKst3sQPWXYfI7V2nPqalgix+cZFUkxh2r2P4TpjGfq9Kkdk3B8VArV3GCw4Sx1mY4ksVARXOtCUJ2xkbtLDGX1PYYRsuQYHBlJAcjPFpBzudMk7nJhqunD30E3yqkraKsm0JMifGaMt80Pc02cgayUKAIQnd6erRmmOMFPhyM=
Message-ID: <ba83582205042823452a3446f6@mail.gmail.com>
Date: Thu, 28 Apr 2005 23:45:40 -0700
From: Gilles Pokam <gpokam@gmail.com>
Reply-To: Gilles Pokam <gpokam@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Kernel memory
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050429061254.GB12654@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ba83582205042816522e2a7a93@mail.gmail.com>
	 <20050429030313.GA10344@taniwha.stupidest.org>
	 <ba8358220504282233754de43b@mail.gmail.com>
	 <20050429054351.GA12654@taniwha.stupidest.org>
	 <ba8358220504282248344d5e78@mail.gmail.com>
	 <20050429061254.GB12654@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Apr 28, 2005 at 10:48:31PM -0700, Gilles Pokam wrote:
> 
> > Can you be more explicit ?
> 
> why can't you have the parent process of whatever your tracing mess
> with /dev/kmem or whatever so you don't have to frob the original
> binary?

I see the point. Just to test this solution, I tried before to modify
a test application by mmaping /dev/mem into the application address
range. Since I don't know apriori which address is going to raise a
pagefault, I had to mmap the entire memory to the user space. However
this doesn't work. It looks like there is a limitation on the amount
of memory you can mmap ?

> i guess it's not really clear to me what you're doing entirely

the simplest way to say is: I want the pagefault handler to return a
memory page when it encounters a pagefault exceptions due to an
invalid address or incorrect page protection.


Thanks. 
Gilles
