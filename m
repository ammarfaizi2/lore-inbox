Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbTEOJl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTEOJl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:41:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:37349 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263932AbTEOJlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:41:24 -0400
Date: Thu, 15 May 2003 02:55:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: riel@redhat.com, dmccr@us.ibm.com, mika.penttila@kolumbus.fi,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-Id: <20030515025539.0067012d.akpm@digeo.com>
In-Reply-To: <20030515094656.GB1429@dualathlon.random>
References: <20030515004915.GR1429@dualathlon.random>
	<Pine.LNX.4.44.0305142234120.20800-100000@chimarrao.boston.redhat.com>
	<20030515094656.GB1429@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 09:54:08.0829 (UTC) FILETIME=[EDE15ED0:01C31AC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > > -	if (page->buffers)
>  > > -		goto preserve;
>  > > +	BUG_ON(page->buffers);
>  > 
>  > I wonder if there is nothing else that can leave behind
>  > buffers in this way.
> 
>  that's why I left the BUG_ON, if there's anything else I want to know,
>  there shouldn't be anything else as the comment also suggest. I recall
>  when we discussed this single check with Andrew and that was the only
>  reason we left it AFIK.

yes, the test should no longer be needed.
