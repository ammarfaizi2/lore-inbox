Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbUKEMWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUKEMWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbUKEMWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:22:31 -0500
Received: from cantor.suse.de ([195.135.220.2]:29382 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262661AbUKEMW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:22:26 -0500
Date: Fri, 5 Nov 2004 13:22:25 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105122225.GA1287@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu> <20041105110951.GA29702@elte.hu> <20041105111751.GC8349@wotan.suse.de> <20041105112404.GA32198@elte.hu> <20041105121528.GA6921@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105121528.GA6921@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 01:15:28PM +0100, Ingo Molnar wrote:
> 
> next problem: the x64 kernel doesnt boot 32-bit userspace anymore. I'm 
> getting an endless stream of segfaults:

I bet that is caused by the flexmmap TASK_SIZE changes.  Can you revert
the 64bit flexmmap patch and see if that helps? 

I tested it before flexmmap and it worked for me.

-Andi

