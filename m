Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUJHBs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUJHBs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUJHBrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:47:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:19939 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268158AbUJHBm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 21:42:28 -0400
Date: Thu, 7 Oct 2004 18:40:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: nickpiggin@yahoo.com.au, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-Id: <20041007184037.4d70c8da.akpm@osdl.org>
In-Reply-To: <20041007175110.Q2357@build.pdx.osdl.net>
References: <20041007142019.D2441@build.pdx.osdl.net>
	<20041007164044.23bac609.akpm@osdl.org>
	<4165E0A7.7080305@yahoo.com.au>
	<20041007173748.0be87160.akpm@osdl.org>
	<20041007175110.Q2357@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
>  Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
>  protections[]: 0 0 0
>  Node 1 Normal free:25272kB min:1020kB low:2040kB high:3060kB active:624172kB inactive:282700kB present:1047936kB
>  protections[]: 0 0 0
>  Node 1 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
>  protections[]: 0 0 0

hm.  empty zones all over the zonelist.   We may not be handling that right.

>  Node 0 DMA free:728kB min:12kB low:24kB high:36kB active:788kB inactive:7848kB present:16384kB
>  protections[]: 0 0 0
>  Node 0 Normal free:27200kB min:1004kB low:2008kB high:3012kB active:332792kB inactive:422744kB present:1032188kB
>  protections[]: 0 0 0
>  Node 0 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
>  protections[]: 0 0 0

I can't see anything here which would cause kswapd to go nuts.
