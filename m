Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTFWHlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTFWHlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:41:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:47167 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264880AbTFWHlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:41:45 -0400
Date: Mon, 23 Jun 2003 00:56:23 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: paulmck@us.ibm.com, dmccr@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-Id: <20030623005623.5fe1ab30.akpm@digeo.com>
In-Reply-To: <20030623074353.GE19940@dualathlon.random>
References: <133430000.1055448961@baldur.austin.ibm.com>
	<20030612134946.450e0f77.akpm@digeo.com>
	<20030612140014.32b7244d.akpm@digeo.com>
	<150040000.1055452098@baldur.austin.ibm.com>
	<20030612144418.49f75066.akpm@digeo.com>
	<184910000.1055458610@baldur.austin.ibm.com>
	<20030620001743.GI18317@dualathlon.random>
	<20030623032842.GA1167@us.ibm.com>
	<20030622233235.0924364d.akpm@digeo.com>
	<20030623074353.GE19940@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2003 07:55:51.0106 (UTC) FILETIME=[DD6B0A20:01C3395C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> that will finally close the race

Could someone please convince me that we really _need_ to close it?

The VM handles the whacky pages OK (on slowpaths), and when this first came
up two years ago it was argued that the application was racy/buggy
anyway.  So as long as we're secure and stable, we don't care.  Certainly
not to the point of adding more atomic ops on the fastpath.

So...   what bug are we actually fixing here?


(I'd also like to see a clearer description of the distributed fs problem,
and how this fixes it).

Thanks.
