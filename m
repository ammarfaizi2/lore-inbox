Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWH3TI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWH3TI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWH3TI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:08:29 -0400
Received: from terminus.zytor.com ([192.83.249.54]:47281 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751344AbWH3TI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:08:28 -0400
Message-ID: <44F5E20A.8070504@zytor.com>
Date: Wed, 30 Aug 2006 12:07:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alon Bar-Lev <alon.barlev@gmail.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <44F1F356.5030105@zytor.com> <20060830205136.4f9bfd33@localhost> <44F5E01C.3010807@zytor.com> <200608302106.18080.ak@suse.de>
In-Reply-To: <200608302106.18080.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 30 August 2006 20:59, H. Peter Anvin wrote:
>> Alon Bar-Lev wrote:
>>> This is not entirely true...
>>> All architectures sets saved_command_line variable...
>>> So I can add __init to the saved_command_line and
>>> copy its contents into kmalloced persistence_command_line at
>>> main.c.
>>>
>> My opinion is that you should change saved_command_line (which already 
>> implies a copy) to be the kmalloc'd version and call the fixed-sized 
>> buffer something else.
> 
> It might be safer to rename everything. Then all users could be caught
> and audited. This would ensure saved_command_line is not accessed
> before the kmalloc'ed copy exists.
> 
> Disadvantage: more architectures to change.
> 

That would definitely be the safest option, and probably is the way to go.

	-hpa
