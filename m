Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWHaRlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWHaRlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWHaRlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:41:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20657 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932397AbWHaRlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:41:50 -0400
Message-ID: <44F71F28.9040108@zytor.com>
Date: Thu, 31 Aug 2006 10:40:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Andi Kleen <ak@suse.de>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <6OyEf-3Zm-5@gated-at.bofh.it> <6PCwg-3mz-43@gated-at.bofh.it> <6PDBU-5Qb-25@gated-at.bofh.it> <6PDBU-5Qb-23@gated-at.bofh.it> <E1GIqPE-00010E-P2@be1.lrz>
In-Reply-To: <E1GIqPE-00010E-P2@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Andi Kleen <ak@suse.de> wrote:
>> On Wednesday 30 August 2006 20:59, H. Peter Anvin wrote:
>>> Alon Bar-Lev wrote:
> 
>>>> This is not entirely true...
>>>> All architectures sets saved_command_line variable...
>>>> So I can add __init to the saved_command_line and
>>>> copy its contents into kmalloced persistence_command_line at
>>>> main.c.
>>>>
>>> My opinion is that you should change saved_command_line (which already
>>> implies a copy) to be the kmalloc'd version and call the fixed-sized
>>> buffer something else.
>> It might be safer to rename everything. Then all users could be caught
>> and audited. This would ensure saved_command_line is not accessed
>> before the kmalloc'ed copy exists.
> 
> If you set the new *saved_cmdline=saved_cmdline_init, the users don't need
> to be adjusted at all, and you won't have trouble with code that may be
> run before or after kmallocking (if it exists).

True for C code, but not for assembly.

	-hpa

