Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVDAWtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVDAWtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVDAWtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:49:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:8085 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262939AbVDAWtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:49:18 -0500
Date: Fri, 1 Apr 2005 14:51:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Ingo Molnar'" <mingo@elte.hu>, Paul Jackson <pj@engr.sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: RE: Industry db benchmark result on recent 2.6 kernels
In-Reply-To: <200504012232.j31MWTg03706@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0504011447580.4774@ppc970.osdl.org>
References: <200504012232.j31MWTg03706@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Apr 2005, Chen, Kenneth W wrote:
> 
> Paul, you definitely want to check this out on your large numa box.  I booted
> a kernel with this patch on a 32-way numa box and it took a long .... time
> to produce the cost matrix.

Is there anything fundamentally wrong with the notion of just initializing
the cost matrix to something that isn't completely wrong at bootup, and
just lettign user space fill it in?

Then you couple that with a program that can do so automatically (ie 
move the in-kernel heuristics into user-land), and something that can 
re-load it on demand.

Voila - you have something potentially expensive that you run once, and 
then you have a matrix that can be edited by the sysadmin later and just 
re-loaded at each boot.. That sounds pretty optimal, especially in the 
sense that it allows the sysadmin to tweak things depending on the use of 
the box is he really wants to.

Hmm? Or am I just totally on crack?

		Linus
