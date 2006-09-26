Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWIZGlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWIZGlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 02:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWIZGlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 02:41:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750724AbWIZGlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 02:41:44 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Bligh <mbligh@google.com>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
Date: Tue, 26 Sep 2006 08:41:27 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
References: <45185A93.7020105@google.com>
In-Reply-To: <45185A93.7020105@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609260841.27413.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 00:39, Martin Bligh wrote:
> http://test.kernel.org/abat/49037/debug/test.log.0	
> 
>    AS      arch/x86_64/boot/bootsect.o
>    LD      arch/x86_64/boot/bootsect
>    AS      arch/x86_64/boot/setup.o
>    LD      arch/x86_64/boot/setup
>    AS      arch/x86_64/boot/compressed/head.o
>    CC      arch/x86_64/boot/compressed/misc.o
>    OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
> BFD: Warning: Writing section `.data.percpu' to huge (ie negative) file 
> offset 0x804700c0.

Most likely that is the problem. I don't know what patch it could be
(none of mine have been merged yet). Can you bisect?

-Andi
