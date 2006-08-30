Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWH3TAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWH3TAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWH3TAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:00:24 -0400
Received: from terminus.zytor.com ([192.83.249.54]:28298 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751171AbWH3TAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:00:23 -0400
Message-ID: <44F5E01C.3010807@zytor.com>
Date: Wed, 30 Aug 2006 11:59:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <44F1F356.5030105@zytor.com>	<200608301856.11125.ak@suse.de>	<20060830200638.504602e2@localhost>	<200608301931.14434.ak@suse.de> <20060830205136.4f9bfd33@localhost>
In-Reply-To: <20060830205136.4f9bfd33@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> 
> This is not entirely true...
> All architectures sets saved_command_line variable...
> So I can add __init to the saved_command_line and
> copy its contents into kmalloced persistence_command_line at
> main.c.
> 

My opinion is that you should change saved_command_line (which already 
implies a copy) to be the kmalloc'd version and call the fixed-sized 
buffer something else.

	-hpa
