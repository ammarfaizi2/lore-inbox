Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUBLUxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUBLUxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:53:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:44951 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266553AbUBLUxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:53:02 -0500
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
References: <1076384799.893.5.camel@gaston>
	 <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
	 <20040210173738.GA9894@mail.shareable.org>
	 <20040213002358.1dd5c93a.ak@suse.de> <20040212100446.GA2862@elte.hu>
	 <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076618966.12467.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 07:49:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One option is to mark the brk() VMA's as being grow-up (which they are), 
> and make get_unmapped_area() realize that it should avoid trying to 
> allocate just above grow-up segments or just below grow-down segments. 
> That's still something of a special case, but at least it's not "magic" 
> any more, now it's more of a "makes sense".

Though we need a way to represent TASK_UNMAPPED_BASE, no ? (as the
limit above which it's ok). 

Ben.


