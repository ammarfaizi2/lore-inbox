Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266213AbUHIIUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUHIIUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUHIIUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:20:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:16865 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266213AbUHIIUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:20:12 -0400
Message-Id: <200408090820.i798Kbj07417@owlet.beaverton.ibm.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, mjbligh@us.ibm.com
Subject: Re: 2.6.8-rc3-mm2 
In-reply-to: Your message of "Sun, 08 Aug 2004 15:29:36 PDT."
             <20040808152936.1ce2eab8.akpm@osdl.org> 
Date: Mon, 09 Aug 2004 01:20:37 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got complaints from arch/i386/mm/discontig.c:

arch/i386/mm/discontig.c: In function `zone_sizes_init':
arch/i386/mm/discontig.c:422: warning: passing arg 4 of `free_area_init_node' makes integer from pointer without a cast
arch/i386/mm/discontig.c:422: warning: passing arg 5 of `free_area_init_node' makes pointer from integer without a cast
arch/i386/mm/discontig.c:422: too many arguments to function `free_area_init_node'
arch/i386/mm/discontig.c:430: warning: passing arg 3 of `free_area_init_node' from incompatible pointer type
arch/i386/mm/discontig.c:430: warning: passing arg 4 of `free_area_init_node' makes integer from pointer without a cast
arch/i386/mm/discontig.c:430: warning: passing arg 5 of `free_area_init_node' makes pointer from integer without a cast
arch/i386/mm/discontig.c:430: too many arguments to function `free_area_init_node'

Looks like I can't get by with just deleting the third argument in the
second case.

Rick
