Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWC2GTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWC2GTe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWC2GTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:19:34 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:23694 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751093AbWC2GTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:19:33 -0500
Message-ID: <442A26E9.20608@vilain.net>
Date: Wed, 29 Mar 2006 18:19:21 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	<1143228339.19152.91.camel@localhost.localdomain>	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>	<4428FB29.8020402@yahoo.com.au>	<20060328142639.GE14576@MAIL.13thfloor.at>	<44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>That plus using the security module infrastructure you can
>implement the semantics pretty in a straight forward manner.
>  
>

Yes, this is the essence of it all. Globals are bad, mmm'kay?

This raises a very interesting question. All those LSM globals,
shouldn't those be virtualisable, too? After all, isn't it natural to
want to apply a different security policy to different sets of processes?

I don't think anyone's done any work on this yet...

Man, fork() is going to get really expensive if we don't put in the
"process family" abstraction... but like you say, it comes later,
getting the semantics right comes first.

>The only really intrusive part is that because we tickle the
>code differently we see a different set of problems.  Such
>as the mess that is the proc and sysctl code, and the lack of
>good resource limits.
>
>But none of that is inherent to the problem it is just when
>you use the kernel harder and have more untrusted users you
>see a different set of problems.
>  
>

Indeed. Lots of old turds to clean up...

Sam.
