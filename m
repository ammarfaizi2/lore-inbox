Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTEOI1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 04:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTEOI1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 04:27:53 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:11231 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263867AbTEOI1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 04:27:53 -0400
Date: Thu, 15 May 2003 01:42:07 -0700
From: Andrew Morton <akpm@digeo.com>
To: andrea@suse.de, dmccr@us.ibm.com, mika.penttila@kolumbus.fi,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-Id: <20030515014207.64be0afa.akpm@digeo.com>
In-Reply-To: <20030515013245.58bcaf8f.akpm@digeo.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
	<20030513181018.4cbff906.akpm@digeo.com>
	<18240000.1052924530@baldur.austin.ibm.com>
	<20030514103421.197f177a.akpm@digeo.com>
	<82240000.1052934152@baldur.austin.ibm.com>
	<20030515004915.GR1429@dualathlon.random>
	<20030515013245.58bcaf8f.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 08:40:37.0870 (UTC) FILETIME=[A8BE70E0:01C31ABD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> So the mm/memory.c part would look something like:

er, right patch, wrong concept.  That's the "check i_size after taking
page_table_lock" patch.

It's actually not too bad.  Yes, there's 64-bit arith involved, but it is
only a shift.

