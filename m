Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWIHRp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWIHRp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWIHRp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:45:28 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52375 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750965AbWIHRp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:45:27 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4501ABB7.6030203@s5r6.in-berlin.de>
Date: Fri, 08 Sep 2006 19:43:19 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc6-mm1
References: <20060908011317.6cb0495a.akpm@osdl.org>
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
...
> +nommu-move-the-fallback-arch_vma_name-to-a-sensible-place.patch
...

I get

	kernel/signal.c:2742: warning: weak declaration of
	'arch_vma_name' after first use results in unspecified behavior

on X86_32, gcc 3.4.1-4mdk.

nommu-move-the-fallback-arch_vma_name-to-a-sensible-place.patch moves
arch_vma_name() into kernel/signal.c, near its end.

vdso-improve-print_fatal_signals-support-by-adding-memory-maps.patch
inserts a call to arch_vma_name() into kernel/signal.c, in the first
half of signal.c.
-- 
Stefan Richter
-=====-=-==- =--= -=---
http://arcgraph.de/sr/
