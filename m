Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTEIRTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTEIRTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:19:39 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:44520 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263339AbTEIRTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:19:38 -0400
Date: Fri, 9 May 2003 13:28:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] i386 uaccess to fixmap pages
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Roland McGrath <roland@redhat.com>
Message-ID: <200305091331_MC3-1-3822-4B95@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> So we'd have to move the kernel to something like
> 0xc0400000 (and preferably higher, to make sure there is a nice hole in
> between - say 0xc1000000), which in turn has a cost of verifying that 
> nothing assumes the current lay-out (we've had the 1/2/3GB TASK_SIZE 
> patches floating around, but they've never had "odd sizes").


 /arch/i386/kernel/doublefault.c:

#define ptr_ok(x) ((x) > 0xc0000000 && (x) < 0xc1000000)
