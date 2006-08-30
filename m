Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWH3TdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWH3TdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWH3TdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:33:23 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39097 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751377AbWH3TdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:33:21 -0400
Message-ID: <44F5E7ED.3050900@zytor.com>
Date: Wed, 30 Aug 2006 12:33:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <44F1F356.5030105@zytor.com>	<200608301856.11125.ak@suse.de>	<20060830200638.504602e2@localhost>	<200608301931.14434.ak@suse.de>	<20060830205136.4f9bfd33@localhost>	<44F5E01C.3010807@zytor.com> <20060830222303.11b35276@localhost>
In-Reply-To: <20060830222303.11b35276@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
>
> Changing saved_command_line is a modification to all
> architectures... They all modify this variable...
> So, should I submit a patch to all architectures? How can I test this?
> 

Submit a patch set, with the common changes in one patch and the 
architecture-specific bits broken out per architecture; that way the 
individual arch maintainers can look at their piece.  Since it's a 
simple variable rename, it shouldn't be a big deal.

> Also for i386 the code is assembly... So I can modify the code to write
> into a __init buffer and then kmalloc in setup.c.

Don't do that.  Just change the name of the buffer in head.S.

	-hpa

