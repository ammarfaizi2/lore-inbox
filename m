Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268838AbUIQP2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268838AbUIQP2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268839AbUIQP1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:27:11 -0400
Received: from zeus.kernel.org ([204.152.189.113]:65270 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268845AbUIQOsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:48:01 -0400
Date: Fri, 17 Sep 2004 07:47:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Stelian Pop <stelian@popies.net>
Cc: andrea@novell.com, hugh@veritas.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040917074707.613fbd57.pj@sgi.com>
In-Reply-To: <20040917133656.GF3089@crusoe.alcove-fr>
References: <20040917102413.GA3089@crusoe.alcove-fr>
	<Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain>
	<20040917122400.GD3089@crusoe.alcove-fr>
	<20040917131523.GQ15426@dualathlon.random>
	<20040917133656.GF3089@crusoe.alcove-fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This discussion reminds me of a fifo I did long ago, when
I had both 80386 and 68020 chips sharing the same fifo.

The key was putting both the put and get (in and out)
indices into one word, and updating them using compare
and swap (cmpxchg, I guess it's called now).

No additional locking needed.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
