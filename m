Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUBLRbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUBLRbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:31:50 -0500
Received: from cs24243203-239.austin.rr.com ([24.243.203.239]:29452 "EHLO
	raptor.int.mccr.org") by vger.kernel.org with ESMTP id S266550AbUBLRbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:31:47 -0500
Date: Thu, 12 Feb 2004 11:31:43 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-ID: <362010000.1076607103@[10.1.1.5]>
In-Reply-To: <Pine.LNX.4.58.0402120912430.5816@home.osdl.org>
References: <1076384799.893.5.camel@gaston>
 <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
 <20040210173738.GA9894@mail.shareable.org>
 <20040213002358.1dd5c93a.ak@suse.de> <20040212100446.GA2862@elte.hu>
 <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
 <339500000.1076605352@[10.1.1.5]>
 <Pine.LNX.4.58.0402120912430.5816@home.osdl.org>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, February 12, 2004 09:17:44 -0800 Linus Torvalds
<torvalds@osdl.org> wrote:

> it it uses RLIMIT_STACK plus a maximum limit (although it's a _big_
> maximum limit, much bigger than we'd use for BSS). So we could do
> something similar for the BSS, with obviously a smaller hard limit (on a 
> 64-bit architecture a gigabyte is fine, but ..)

Hmm... would it work to just do something like 'if the previous vma is
grow-up then allocate from the top of the hole'?  It'd eliminate the need
for a hard limit and should pretty much stay out of the way of BSS.

Dave McCracken

