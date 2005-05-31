Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVEaMFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVEaMFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVEaMFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:05:37 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:59367 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261326AbVEaMFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:05:34 -0400
Message-ID: <429C530E.70704@stud.feec.vutbr.cz>
Date: Tue, 31 May 2005 14:05:34 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net>
In-Reply-To: <200505310753.49447.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
>   CC      kernel/latency.o
> kernel/latency.c:854: error: `NR_syscalls' undeclared here (not in a function)
> 
> x86_64 doesn't seem to be defining NR_syscalls anywhere.. Shouldn't it be part 
> of unistd.h as other arches do?

I noticed that error too. AFAIK this is not a new error in -RT, 
latency.o never compiled on x86_64 for me.
For now just disable Latency tracing (CONFIG_LATENCY_TRACE).

Michal
