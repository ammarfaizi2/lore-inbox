Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUIWOQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUIWOQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 10:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUIWOQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 10:16:31 -0400
Received: from relay.pair.com ([209.68.1.20]:35855 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268483AbUIWOQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:16:29 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4152DA39.3010300@kegel.com>
Date: Thu, 23 Sep 2004 07:14:17 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjanv@redhat.com
Subject: Re: 2.6.8 link failure for powerpc-970?
References: <414E93BC.4080107@kegel.com> <1095669339.2800.3.camel@laptop.fenrus.com> <4150EF69.1060007@kegel.com> <4151AB3D.3040003@kegel.com> <20040922222723.GD30109@MAIL.13thfloor.at> <41525E05.7020506@kegel.com> <20040923131229.GA4785@krispykreme>
In-Reply-To: <20040923131229.GA4785@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
>  
> 
>>Sure.  For ppc64, beyond allnoconfig, I had to enable
>>CONFIG_SYSVIPC
>>CONFIG_SYSCTL
>>CONFIG_NET
>>... um, but that didn't fix everything.  Now it fails with
> 
> 
> OK, I guess we need some better wrapping of compat code.

Yeah, probably for several of the 64 bit arches.  Sounds like
a nice little kernel-janitor project.

>>Um, why is it using the host's gcc?  I ran make with
>>make V=1 ARCH=ppc64 
>>CROSS_COMPILE=/opt/crosstool/powerpc64-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin/powerpc64-unknown-linux-gnu-
>>so it really should know better, shouldn't it?
> 
> 
> Check out arch/ppc64/boot/Makefile, in particular CROSS32_COMPILE. The
> boot wrapper is a 32bit binary. 
> 
> Now that the toolchain is biarch capable we could get rid of that and
> use gcc -m32 instead. But for the moment specify a CROSS32_COMPILE ant
> things should link.

Aha!  Got it.  Thanks!
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
