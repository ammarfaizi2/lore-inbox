Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbUK2Tk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUK2Tk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUK2TiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:38:06 -0500
Received: from 209-128-68-124.bayarea.net ([209.128.68.124]:28342 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261765AbUK2TZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:25:17 -0500
Message-ID: <41AB7790.5050404@zytor.com>
Date: Mon, 29 Nov 2004 11:25:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linus Torvalds <torvalds@Osdl.ORG>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow compiling i386 with an x86-64 compiler
References: <41A4B52D.2030402@zytor.com> <20041129185004.GF22325@smtp.west.cox.net>
In-Reply-To: <20041129185004.GF22325@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Nov 24, 2004 at 08:22:05AM -0800, H. Peter Anvin wrote:
> 
> 
>>This patch adds -m32 if gcc supports it, thus making it easier to 
>>compile the i386 architecture with an x86-64 compiler.
>>
>>Note that it adds the option to CC, since it also affects assembly code 
>>and linking.  The extra level of indirection is because $(call 
>>cc-option) itself uses $(CC), so just doing CC += ... would cause $(CC) 
>>to be recursively defined.
> 
> 
> Just so 'bi-arch' arches look the same, I'd like to suggest (and stolen
> from ppc32) something like:
> HAS_BIARCH      := $(call cc-option-yn, -m32)
> ifeq ($(HAS_BIARCH),y)
> CC := $(CC) -m32
> endif
> 
> Up near the top...
> 

I'm not really happy with it, because it's misleading; it implies it 
tests for a working x86-64 devel environment, which it doesn't.  It's 
not a strong opinion, though.

	-hpa

