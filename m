Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSAHOF6>; Tue, 8 Jan 2002 09:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288052AbSAHOFr>; Tue, 8 Jan 2002 09:05:47 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:27033 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S288051AbSAHOFi>;
	Tue, 8 Jan 2002 09:05:38 -0500
In-Reply-To: <20020107224525.8a899969dbcd@remtk.solucorp.qc.ca>
            <BD98BECA-0407-11D6-804A-00039355CFA6@suespammers.org>
            <20020108122225.B11855@xs4all.nl>
In-Reply-To: <20020108122225.B11855@xs4all.nl> 
From: "Anthony DeRobertis" <asd@suespammers.org>
To: jtv <jtv@xs4all.nl>
Cc: Anthony DeRobertis <asd@suespammers.org>,
        Jacques Gelinas <jack@solucorp.qc.ca>, linux-kernel@vger.kernel.org
Subject: Re: Whizzy New Feature: Paged segmented memory
Date: Tue, 08 Jan 2002 14:05:09 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <E16NwsH-0005Ud-00@asd.ppp0.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jtv writes: 

> On Tue, Jan 08, 2002 at 02:17:14AM -0500, Anthony DeRobertis wrote:
>> 
>> A nice thing about two stacks is that it can be a completely 
>> userspace thing. No need to involve the kernel at all; just gcc 
>> and friends.
> 
> Doesn't it have ABI implications as well?

On every architecture I'm familiar with. But that's a userland issue. I 
don't believe the kernel cares how userland uses its stacks. 

Change gcc. Recompile world. All should work, assuming your gcc changes are 
bug-free, no one made assumptions about stack layout, no one wrote assembly 
code, etc. [In other words, after 4 months of debugging you might get X 
running again...] 

> 
> If so, why not go all the way and have stacks grow upwards?  :-)

Some architectures have hardware assistance for downward growing stacks. One 
example is 68K. I think x86 does too. OTOH, I don't think PPC does, though I 
haven't read the Green Book recently. 

Actually, if I were to be implementing split-stack, I'd probably have one 
grow upward. Probably the data stack, because some architectures (68K, at 
least) force the address stack to grow downwards. 

Put an unmapped page between the two stacks, and all should be fine. 

>  
> 
> Jeroen 
> 
 
