Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268390AbUHLEld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268390AbUHLEld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 00:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUHLEld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 00:41:33 -0400
Received: from [12.177.129.25] ([12.177.129.25]:18116 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268398AbUHLEkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 00:40:25 -0400
Message-Id: <200408120541.i7C5fIJd010913@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: William Lee Irwin III <wli@holomorphy.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] 2.6.8-rc4-mm1 - UML fixes 
In-Reply-To: Your message of "Wed, 11 Aug 2004 20:30:12 PDT."
             <20040812033012.GE11200@holomorphy.com> 
References: <200408120415.i7C4FWJd010494@ccure.user-mode-linux.org>  <20040812033012.GE11200@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Aug 2004 01:41:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com said:
> Out of curiosity, why are you allocating 4*PAGE_SIZE for the stack if
> you're only going to use 2*PAGE_SIZE of it? I saw no other users for
> the rest of ->thread_info offhand. 

Well, that's slightly misleading.  The other two pages (minus the thread_info)
are available for stack if needed.  UML stacks are somewhat larger than the
native kernel stacks because of the userspace signal frames, so I allocate
4 pages for now to be safe.

				Jeff

