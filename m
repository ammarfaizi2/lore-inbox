Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVEZSqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVEZSqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEZSqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:46:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32206 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261694AbVEZSqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:46:33 -0400
Date: Thu, 26 May 2005 11:46:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: holt@sgi.com, Simon.Derr@bull.net, akpm@osdl.org, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
Message-Id: <20050526114609.2c01a485.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0505260840470.2307@ppc970.osdl.org>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
	<Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
	<20050526120859.GD29852@lnx-holt.americas.sgi.com>
	<Pine.LNX.4.58.0505260840470.2307@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> For this, there is a nice 
> 
> 	atomic_dec_and_lock()
> 
> function that is the same as "atomic_dec_and_test()", except it grabs the 
> lock if the count decrements to zero.

If we take Robin's idea to add a spinlock per cpuset, then yes this
atomic_dec_and_lock() might be useful.  Thanks for mentioning it.

I am not convinced we need to go that way.  See my upcoming replies to
Simon and Robin, for alternative approaches that are simpler.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
