Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264718AbUEEQZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264718AbUEEQZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUEEQZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:25:09 -0400
Received: from dsl092-109-241.nyc2.dsl.speakeasy.net ([66.92.109.241]:5617
	"EHLO gandalf.taltos.org") by vger.kernel.org with ESMTP
	id S264718AbUEEQZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:25:02 -0400
Date: Wed, 05 May 2004 12:25:00 -0400
From: Carson Gaspar <carson@taltos.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marco Fais <marco.fais@abbeynet.it>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <765880000.1083774300@taltos.ny.ficc.gs.com>
In-Reply-To: <20040504010714.GA8028@logos.cnet>
References: <406D3E8F.20902@abbeynet.it> <20040504010714.GA8028@logos.cnet>
X-Mailer: Mulberry/3.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, May 03, 2004 22:07:14 -0300 Marcelo Tosatti 
<marcelo.tosatti@cyclades.com> wrote:

> On Fri, Apr 02, 2004 at 12:21:03PM +0200, Marco Fais wrote:
>> Hi!
>>
>>
>> [1.] Kernel panic while using distcc
>>
>> [2.] I have 5-6 development linux systems that we use without problem
>> under a normal development workload. Trying distcc for speeding up
>> compilation, we have a fully reproducible kernel panic in a very short
>> time (seconds after compilation start). The kernel panic happens *only*
>> when the systems are "remotely controlled" (the distcc daemon is
>> receiving source files from remote systems, compile and send back
>> compiled objects). When compiling with distcc the local system doesn't
>> show any kernel panic, while the same system used as a "remote compiler
>> system" dies very quickly.
>>
>> [3.] Keywords: distcc BUG page_alloc.c
>
> Marco, Carson,
>
> Can you please try to reproduce this distcc generated oops using
> 2.4.27-pre2?

I'd love to. However 2.4.27-pre2 broke the tg3 driver. tg3.c contains 
WARN_ON(1). Sadly, WARN_ON doesn't exist in 2.4.x, so depmod correctly 
complains about an unresolved symbol.

I'm beginning to wonder if anyone actually builds these pre releases... I 
mean, I know the tg3 driver is really obscure, and only used by 2 people, 
but...

-- 
Carson

