Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbTF1Wp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 18:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbTF1Wp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 18:45:57 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:10139 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265442AbTF1Wp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 18:45:56 -0400
Date: Sat, 28 Jun 2003 16:00:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-Id: <20030628160013.46a5b537.akpm@digeo.com>
In-Reply-To: <20030628155436.GY20413@holomorphy.com>
References: <20030627202130.066c183b.akpm@digeo.com>
	<20030628155436.GY20413@holomorphy.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2003 23:00:13.0556 (UTC) FILETIME=[086C9340:01C33DC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
>  Here's highpmd.

I taught patch-scripts a new trick:

check_patch()
{
	if grep "^+.*[ 	]$" $P/patches/$1.patch
	then
		echo warning: $1 adds trailing whitespace
	fi
}


+       if (pmd_table != pmd_offset_kernel(pgd, 0)) 
+       pmd = pmd_offset_kernel(pgd, address);         
+#define __pgd_page(pgd)                (__bpn_to_ba(pgd_val(pgd))) 
warning: highpmd adds trailing whitespace

You're far from the worst.   There's some editor out there which
adds trailing tabs all over the place.  I edited the diff.

What architectures has this been tested on?
