Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVICPBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVICPBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVICPBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:01:24 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:56212 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1750787AbVICPBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:01:24 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <4319BABB.20509@zytor.com>
Date: Sat, 03 Sep 2005 08:01:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org> <4319330C.5030404@zytor.com> <20050903055007.GA30966@codepoet.org> <43193A4F.5030906@zytor.com> <20050903064124.GA31400@codepoet.org>
In-Reply-To: <20050903064124.GA31400@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> 
> That is certainly not what I was proposing.  Why are you bringing
> sys/stat.h into this?  The contents of sys/stat.h are entirely up
> to SUSv3 and the C library to worry about.  Nobody has proposed
> mucking with that.  I dunno about your C library, but mine
> doesn't include linux/* header files (not even sys/stat.h).  And
> I'd really like to fix uClibc to not use any asm/* either, since
> much of it is entirely unsuitable for user space.
> 

I'm in particular commenting on the stat structure involved with the 
kernel interface.

> I am proposing a single consistant policy for all of linux/* such
> that all linux/* headers that need integer types of a specific
> size shall #include unistd.h and use ISO C99 types rather that
> the ad-hoc kernel types they now use.
> 
> The policy has _long_ been that user space must never include
> linux/* header files.  Since we are now proposing a project to
> reverse this policy, the long standing policy making linux/*
> verboten now leaves us completely free to do pretty much anything
> with linux/*.  And what I want is for linux/* to use the shiny
> ISO C99 types.

And I'm pointing out that that you're not only excluding a whole major 
portion of the kernel ABI from this mechanism if you do that, you're 
effectively requiring new mechanisms every time something is included 
into POSIX over time!  If that isn't insane, I don't know what is.

	-hpa
