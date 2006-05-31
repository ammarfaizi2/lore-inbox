Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751735AbWEaRAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbWEaRAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 13:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbWEaRAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 13:00:48 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:50701 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751733AbWEaRAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 13:00:47 -0400
Message-ID: <447DCBAD.8070307@shadowen.org>
Date: Wed, 31 May 2006 18:00:29 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Chad Reese <creese@caviumnetworks.com>
Subject: Re: mem_map definition / declaration.
References: <20060531162345.GA19674@linux-mips.org>
In-Reply-To: <20060531162345.GA19674@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> mm/memory defines mem_map and max_mapnr only if !CONFIG_NEED_MULTIPLE_NODES.
> <linux/mm.h> declares mem_map[] if !CONFIG_DISCONTIGMEM.  Shouldn't
> both depend on !CONFIG_FLATMEM?  As things are now mem_map may be
> declared but not defined for a non-NUMA sparsemem system which may make
> tracking a remaining mem_map reference in the code a little harder.

Sounds suspect for sure.  I will take a look and see.  Thanks for the
head up.

-apw
