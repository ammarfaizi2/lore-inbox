Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbTDEWTI (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTDEWTI (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:19:08 -0500
Received: from [12.47.58.55] ([12.47.58.55]:50063 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262693AbTDEWTI (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:19:08 -0500
Date: Sat, 5 Apr 2003 14:31:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030405143138.27003289.akpm@digeo.com>
In-Reply-To: <20030405220621.GG1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com>
	<12880000.1049508832@flay>
	<20030405024414.GP16293@dualathlon.random>
	<20030404192401.03292293.akpm@digeo.com>
	<20030405040614.66511e1e.akpm@digeo.com>
	<20030405163003.GD1326@dualathlon.random>
	<20030405132406.437b27d7.akpm@digeo.com>
	<20030405220621.GG1326@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 22:30:33.0456 (UTC) FILETIME=[F8B3DF00:01C2FBC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> I see what you mean, you're right. That's because all the 10,000 vma
> belongs to the same inode.

I see two problems with objrmap - this search, and the complexity of the
interworking with nonlinear mappings.

There is talk going around about implementing some more sophisticated search
structure thatn a linear list.

And treating the nonlinear mappings as being mlocked is a great
simplification - I'd be interested in Ingo's views on that.

