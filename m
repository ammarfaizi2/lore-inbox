Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUDFGt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 02:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUDFGt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 02:49:29 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:48284 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263636AbUDFGtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 02:49:25 -0400
Message-ID: <407252F2.3090102@yahoo.com.au>
Date: Tue, 06 Apr 2004 16:49:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, wli@holomorphy.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
References: <20040329041253.5cd281a5.pj@sgi.com>	<1081128401.18831.6.camel@bach>	<20040405000528.513a4af8.pj@sgi.com>	<1081150967.20543.23.camel@bach>	<20040405010839.65bf8f1c.pj@sgi.com>	<1081227547.15274.153.camel@bach>	<20040405230601.62c0b84c.pj@sgi.com>	<40724CF4.5090705@yahoo.com.au> <20040405233415.2c7c3a96.pj@sgi.com>
In-Reply-To: <20040405233415.2c7c3a96.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>I like cpumask_t. 
> 
> 
> Ok - one vote for cpumask_t.
> 
> I could go either way.  I see that 'struct foo' is more common than
> 'foo_t' in kernel code.
> 
> I will not actually propose to change cpumask_t to 'struct cpumask'
> unless others want it.  Without a half-way decent reason, it would just
> be stupid churning.  But I wouldn't put up much resistance to such a
> change.
> 

I think Linus likes keeping struct around if something is
a collection of items both conceptually and in its usage.
And prefers typedefs for things that are single entities
outside their implementation.


> 
> 
>>And you should not need to look inside it or use it with
>>anything other than using the cpumask interface, right?
> 
> 
> In my view, right - you (seldom) need to look inside.  From what I can
> make of Rusty's statements so far, he apparently has a different view ;).
> 

I prefer your complete API. I don't think there is any point
doing the abstraction at all if you only have half the API.
