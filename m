Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUIPN67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUIPN67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUIPN67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:58:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41606 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268076AbUIPN6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:58:19 -0400
Date: Thu, 16 Sep 2004 06:57:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Stelian Pop <stelian@popies.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040916065750.106fc170.pj@sgi.com>
In-Reply-To: <20040916104535.GA3146@crusoe.alcove-fr>
References: <20040913135253.GA3118@crusoe.alcove-fr>
	<20040915153013.32e797c8.akpm@osdl.org>
	<20040916064320.GA9886@deep-space-9.dsnet>
	<20040916000438.46d91e94.akpm@osdl.org>
	<20040916104535.GA3146@crusoe.alcove-fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This still has a 'size' attribute.  As Andrew noted,
this might not be needed.

See for example:

  http://cse.stanford.edu/class/cs110/handouts/27Queues.pdf

for coding a fifo queue with just a put and get pointer.

The queue is empty if put == get, and it is full if adding one more
would make it empty.  The number of elements in the queue can be done
using modulo arithmetic on the difference between put and get (or what
the above *.pdf file and your code calls head and tail), with no
distinct 'size' element.   The head and tail wrap.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
