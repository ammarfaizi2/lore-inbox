Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWH0Sug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWH0Sug (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWH0Sug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:50:36 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25494 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750780AbWH0Suf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:50:35 -0400
Message-ID: <44F1E970.1050709@zytor.com>
Date: Sun, 27 Aug 2006 11:50:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <445B5524.2090001@gmail.com> <445BCA33.30903@zytor.com>	<6.2.3.4.0.20060505204729.036dfdf8@pop-server.san.rr.com>	<445C301E.6060509@zytor.com> <44AD583B.5040007@gmail.com>	<44AD5BB4.9090005@zytor.com> <44AD5D47.8010307@gmail.com>	<44AD5FD8.6010307@zytor.com>	<9e0cf0bf0608031436x19262ab0rb2271b52ce75639d@mail.gmail.com>	<44D278D6.2070106@zytor.com>	<9e0cf0bf0608031542q2da20037h828f4b8f0d01c4d5@mail.gmail.com>	<44D27F22.4080205@zytor.com> <44EF8E7D.5060905@gmail.com> <p73irkedod2.fsf@verdi.suse.de>
In-Reply-To: <p73irkedod2.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> The last time I tried this on x86-64 lilo on systems that used EDD broke.
> EDD uses part of the bootup page too. So most likely it's not that simple.
> 
> And please don't shout your subjects.
> 

On i386, the command line is never stored in the bootup page; only a 
pointer to it is.  The copying is done straight into the 
saved_command_line buffer in the kernel BSS (head.S lines 79-104).

x86-64 does the same thing, but in C code (head64.c lines 45-56.)  Thus, 
if you had a problem with LILO, I suspect the problem was inside LILO 
itself, and not a kernel issue.

	-hpa
