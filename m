Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263817AbUE1TLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUE1TLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUE1TLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:11:14 -0400
Received: from holomorphy.com ([207.189.100.168]:27264 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263817AbUE1TLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:11:13 -0400
Date: Fri, 28 May 2004 12:11:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Patrick Finnegan <pat@computer-refuge.org>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: [PATCH] Alpha compile error on 2.6.7-rc1
Message-ID: <20040528191104.GA2370@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Patrick Finnegan <pat@computer-refuge.org>,
	linux-kernel@vger.kernel.org, rth@twiddle.net
References: <200405281405.30638.pat@computer-refuge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405281405.30638.pat@computer-refuge.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 02:05:30PM -0500, Patrick Finnegan wrote:
> Machine is a 21164A Alpha (164LX motherboard).  The error is:
>   CC      arch/alpha/mm/init.o
> arch/alpha/mm/init.c: In function `show_mem':
> arch/alpha/mm/init.c:120: structure has no member named `count'
> make[1]: *** [arch/alpha/mm/init.o] Error 1
> make: *** [arch/alpha/mm] Error 2
> Patch is below.
> Alpha: Fixup arch/alpha/mm/init.c to match struct page changes 

Might be a better idea to use page_count(&mem_map[i]).


-- wli
