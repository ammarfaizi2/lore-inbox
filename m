Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422963AbWJFU6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422963AbWJFU6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422961AbWJFU6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:58:43 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:60089 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422960AbWJFU6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:58:42 -0400
Date: Fri, 6 Oct 2006 22:52:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthew Wilcox <matthew@wil.cx>
cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <20061006203919.GS2563@parisc-linux.org>
Message-ID: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >+ *   the massive ternary operator construction
>> >+	(sizeof(n) <= 4) ?			\
>> >+	__ilog2_u32(n) :			\
>> >+	__ilog2_u64(n)				\
>> 
>> Should not this be: sizeof(n) <= sizeof(u32)
>
>Were you planning on porting Linux to a machine with non-8-bit-bytes any
>time soon?  Because there's a lot more to fix than this.

I am considering the case [assuming 8-bit-byte machines] where 
sizeof(u32) is not 4. Though I suppose GCC will probably make a 32-bit 
type up if the hardware does not know one.


	-`J'
-- 
