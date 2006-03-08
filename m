Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWCHP7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWCHP7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 10:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWCHP7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 10:59:41 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:65288 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751447AbWCHP7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 10:59:40 -0500
Message-ID: <440EFF08.3040604@cfl.rr.com>
Date: Wed, 08 Mar 2006 10:58:00 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: Benjamin LaHaise <bcrl@kvack.org>, Dan Aloni <da-x@monatomic.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Status of AIO
References: <20060306062402.GA25284@localdomain>  <20060306211854.GM20768@kvack.org>  <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com>  <440CC29F.2060906@cfl.rr.com> <a36005b50603072309w3b622edek5c6c2e7b59d7b2d5@mail.gmail.com>
In-Reply-To: <a36005b50603072309w3b622edek5c6c2e7b59d7b2d5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2006 16:01:29.0843 (UTC) FILETIME=[90003430:01C642C9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14311.000
X-TM-AS-Result: No--1.400000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> What has network I/O to do with O_DIRECT?  I'm talking about async network I/O.

O_DIRECT allows for zero copy IO, which saves a boatload of cpu cycles. 
  For disk IO it is possible to use O_DIRECT without aio, but there is 
generally a loss of efficiency doing so.  For network IO, O_DIRECT is 
not even possible without aio.

By using aio and O_DIRECT for network IO, you can achieve massive 
performance and scalability gains.

You said before that the kernel aio interface is not suitable for 
sockets.  Why not?


