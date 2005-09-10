Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVIJRio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVIJRio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 13:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVIJRio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 13:38:44 -0400
Received: from smtpout.mac.com ([17.250.248.87]:21241 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932122AbVIJRin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 13:38:43 -0400
In-Reply-To: <20050910014543.1be53260.akpm@osdl.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com> <dfhs4u$1ld$1@terminus.zytor.com> <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com> <9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com> <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com> <20050910014543.1be53260.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, bunk@stusta.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined by GCC from 2.95 to current CVS)
Date: Sat, 10 Sep 2005 13:38:15 -0400
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 10, 2005, at 04:45:43, Andrew Morton wrote:
> This patch seems to have a rather low value-to-noise ratio.  Why
> on earth do we want to do this?

When I started trying to split out the userspace<=>kernelspace ABI  
headers, I
found a number of things (such as __ASSEMBLY__) that would not operate
properly in userspace.  I did a bit of research and noticed that GCC  
had a
macro __ASSEMBLER__ defined everywhere we wanted __ASSEMBLY__ to be  
defined,
except probably more reliably (IE: We don't need to manually pass  
flags to
gas).  I figured that if I was going to change the linux-core headers, I
might as well change the rest.  If you don't think this is  
appropriate, I
would be interested to hear your opinion, although it might have  
saved me a
bunch of work if you had brought up your issues before I split the thing
into chunks. :-D

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so
simple that there are obviously no deficiencies. And the other way is  
to make
it so complicated that there are no obvious deficiencies.  The first  
method is
far more difficult.
   -- C.A.R. Hoare


