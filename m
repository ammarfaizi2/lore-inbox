Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUESUej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUESUej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUESUej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:34:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:7298 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264540AbUESUeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:34:37 -0400
Subject: Re: [Ext2-devel] Re: [PATCH] use-before-uninitialized value in
	ext3(2)_find_ goal
From: Mingming Cao <cmm@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       marcelo.tosatti@cyclades.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040519125328.J22989@build.pdx.osdl.net>
References: <20040519043235.30d47edb.akpm@osdl.org>
	<1084992705.15395.1276.camel@w-ming2.beaverton.ibm.com> 
	<20040519125328.J22989@build.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 May 2004 13:33:39 -0700
Message-Id: <1084998821.15395.1287.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 12:53, Chris Wright wrote:
> 
> I know it's a slightly bigger patch, but would it make sense to just enforce
> this as part of api?  Just a thought...(patch untested)

The patch itself (in both your way and my way) is trivial, so either way
is okey. 

But the changes it bring up is not trivial, the ext2/3 disk layout for
random writes could be changed heavily, though that's the expected way
(and hopefully result in the good direction). We need to benchmark the
random write on ext2/3 to see what the changes bring about.

I will try random writes on some benchmark later today.

Mingming

