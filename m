Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266095AbUFPDIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266095AbUFPDIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUFPDIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:08:24 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:45750 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266095AbUFPDFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:05:38 -0400
Message-ID: <40CFB8FD.2010601@yahoo.com.au>
Date: Wed, 16 Jun 2004 13:05:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, mingo@elte.hu, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au, akpm@osdl.org,
       wli@holomorphy.com, torvalds@osdl.org, markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
References: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au>
In-Reply-To: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Martin J. Bligh <mbligh@aracnet.com> wrote:
> 
>>How the hell can that have any effect on non-threaded workloads? Perhaps
>>some part of kernel compile *is* multi-threaded. It does seem to get 
> 
> 
> make(1) with vfork(2) perhaps?

I think balance on clone probably needs to be turned off by default
presently.

It slows down a simple thread creation test by a factor of 7(!) here,
and has quite a few not too difficult to imagine performance problems.

