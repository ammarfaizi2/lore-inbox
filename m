Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWBBVbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWBBVbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWBBVbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:31:46 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:58121 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932281AbWBBVbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:31:44 -0500
Message-ID: <43E27A2E.9020000@shadowen.org>
Date: Thu, 02 Feb 2006 21:31:26 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xquad_portio fix declaration missmatch
References: <20060202004306.GA32466@shadowen.org> <20060202172609.GA4231@mipter.zuzino.mipt.ru>
In-Reply-To: <20060202172609.GA4231@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Thu, Feb 02, 2006 at 12:43:06AM +0000, Andy Whitcroft wrote:
> 
>>xquad_portio fix declaration missmatch
> 
> 
>>  arch/i386/boot/compressed/misc.c:125: error: static declaration of
>>				'xquad_portio' follows non-static declaration
>>  include/asm/io.h:315: error: previous declaration of 'xquad_portio' was here
> 
> 
>>--- reference/arch/i386/boot/compressed/misc.c
>>+++ current/arch/i386/boot/compressed/misc.c
>>@@ -122,7 +122,7 @@ static int vidport;
>> static int lines, cols;
>> 
>> #ifdef CONFIG_X86_NUMAQ
>>-static void * xquad_portio = NULL;
>>+void * xquad_portio = NULL;
>> #endif
> 
> 
> Can you explain why it should stay in misc.c?

Indeed it does feel like it should be a numaq special in the numaq
specific files.  I'll spin that and test it and see if there is a reason
why its _not_ like that already.

-apw
