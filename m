Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUDFGzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 02:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUDFGzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 02:55:24 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:24398 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263635AbUDFGzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 02:55:19 -0400
Message-ID: <40725455.5040407@yahoo.com.au>
Date: Tue, 06 Apr 2004 16:55:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Paul Jackson <pj@sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
References: <20040329041253.5cd281a5.pj@sgi.com>	 <1081128401.18831.6.camel@bach> <20040405000528.513a4af8.pj@sgi.com>	 <1081150967.20543.23.camel@bach> <20040405010839.65bf8f1c.pj@sgi.com>	 <1081227547.15274.153.camel@bach>  <20040405230601.62c0b84c.pj@sgi.com> <1081233543.15274.190.camel@bach>
In-Reply-To: <1081233543.15274.190.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Tue, 2004-04-06 at 16:06, Paul Jackson wrote:
> 
>>>You'll have covered about 300 of them.  I don't think a complete
>>>abstraction is actually required or desirable:
>>
>>I suspect we've hit on our first area of actual disagreement here.
>>
>>You observe that providing inline wrappers for the 5 most commonly
>>used cpumask macros would cover 300 of the 420 uses.  The other 23
>>or so macros are less commonly used.  Sounds about right ...
>>
>>I prefer to provide all 28 macros.  I don't see a cost, but do see
>>a gain.
> 
> 
> Because I believe one should *always* resist the urge to write
> infrastructure.  Wait until the users of your functionality gather out
> the front of your house with torches because they're all sick of the
> burden of using existing infrastructure.
> 
> Really.
> 
> I don't even want to learn 28 bitops primitives.  I certainly don't want
> to learn 28 nodemask and 28 cpumask primitives.
> 

If they are all equivalent operations, it is a lot saner
than having some "common" half ot the API available to
your abstract type, isn't it?

Surely it would have to be all or nothing...
