Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTDFBpw (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 20:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbTDFBpw (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 20:45:52 -0500
Received: from [12.47.58.55] ([12.47.58.55]:18843 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262763AbTDFBpv (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 20:45:51 -0500
Date: Sat, 5 Apr 2003 17:58:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030405175824.316efe90.akpm@digeo.com>
In-Reply-To: <20030405231008.GI1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com>
	<12880000.1049508832@flay>
	<20030405024414.GP16293@dualathlon.random>
	<20030404192401.03292293.akpm@digeo.com>
	<20030405040614.66511e1e.akpm@digeo.com>
	<20030405163003.GD1326@dualathlon.random>
	<20030405132406.437b27d7.akpm@digeo.com>
	<20030405220621.GG1326@dualathlon.random>
	<20030405143138.27003289.akpm@digeo.com>
	<20030405231008.GI1326@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Apr 2003 01:57:17.0158 (UTC) FILETIME=[D9E29860:01C2FBDF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Esepcially those sigbus in the current api
> would be more expensive than the regular paging internal to the VM and
> besides the signal it would generate flood of syscalls and kind of
> duplication of memory management inside the userspace.

That went away.  We now encode the file offset in the unmapped ptes, so the
kernel's fault handler can transparently reestablish the page.

