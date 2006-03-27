Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWC0ATW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWC0ATW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWC0ATW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:19:22 -0500
Received: from smtpout.mac.com ([17.250.248.84]:48116 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932262AbWC0ATV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:19:21 -0500
In-Reply-To: <200603261618.30090.rob@landley.net>
References: <200603141619.36609.mmazur@kernel.pl> <1143394195.3055.1.camel@laptopd505.fenrus.org> <4426D609.2050700@argo.co.il> <200603261618.30090.rob@landley.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D83B3618-200F-4D4F-92E4-9EF85CAC8625@mac.com>
Cc: Avi Kivity <avi@argo.co.il>, Arjan van de Ven <arjan@infradead.org>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 19:18:52 -0500
To: Rob Landley <rob@landley.net>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 16:18:29, Rob Landley wrote:
>>> The problem is things like u64 etc that is VERY common in all  
>>> headers, but then again __u64 etc are just fine, history has  
>>> proven that already.
>>
>> Agree. But to be on the safe side one can use uint64_t and friends  
>> (which the kernel can typedef to u64 and first degree relatives)
>
> Now that the kernel no longer targets gcc before 3.2, c99 names are  
> merely ugly rather than an actual problem. :)

No, they're still a problem in ABI headers because they have defined  
visibility.  A userspace program that does not include <stdint.h>  
will not have those types put in its namespace.  Including <sys/ 
time.h> _cannot_ bring <stdint.> in automatically, that breaks the  
POSIX symbol visibility rules.

Cheers,
Kyle Moffett

