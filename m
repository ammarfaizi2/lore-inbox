Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTKYFHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 00:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTKYFHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 00:07:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:38309 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261967AbTKYFHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 00:07:46 -0500
Date: Mon, 24 Nov 2003 21:14:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] Make balance_dirty_pages zone aware (1/2)
Message-Id: <20031124211415.501ab952.akpm@osdl.org>
In-Reply-To: <1070800000.1069736303@[10.10.2.4]>
References: <3FBEB27D.5010007@us.ibm.com>
	<20031123143627.1754a3f0.akpm@osdl.org>
	<1034580000.1069688202@[10.10.2.4]>
	<20031124100043.5416ed4c.akpm@osdl.org>
	<39670000.1069719009@flay>
	<20031124170506.4024bb30.akpm@osdl.org>
	<1070800000.1069736303@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> "dd if=/dev/zero of=foo" would trigger it, I'd think. Watching the IO
>  rate, it should go wierd after ram is full (on a 3 or more node system, 
>  so there's < 40% of RAM for each node).

We should just prod kswapd into cleansing the relevant zone(s) and go do
allocation from the next one.

> Yeah, I know you're going to give me crap for not actually trying it 

How much would you like?

(Wanders off, wondering how to fix a problem which cannot be
demonstrated).
