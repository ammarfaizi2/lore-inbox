Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSJVWLr>; Tue, 22 Oct 2002 18:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264906AbSJVWLq>; Tue, 22 Oct 2002 18:11:46 -0400
Received: from rth.ninka.net ([216.101.162.244]:10897 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264920AbSJVWLq>;
	Tue, 22 Oct 2002 18:11:46 -0400
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
From: "David S. Miller" <davem@rth.ninka.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0210221936010.18790-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210221936010.18790-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 15:27:55 -0700
Message-Id: <1035325675.16084.11.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 10:57, Ingo Molnar wrote:
> -	flush_tlb_page(vma, addr);
> +	if (flush)
> +		flush_tlb_page(vma, addr);

You're still using page level flushes, even though we agreed that
a range flush one level up was more appropriate.

