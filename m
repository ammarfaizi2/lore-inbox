Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUIMPM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUIMPM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUIMPJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:09:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:37767 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267749AbUIMO72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:59:28 -0400
Date: Mon, 13 Sep 2004 15:58:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Roman Zippel <zippel@linux-m68k.org>
cc: Alex Zarochentsev <zam@namesys.com>, Paul Jackson <pj@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined
    atomic_sub_and_test
In-Reply-To: <Pine.LNX.4.61.0409131608530.877@scrub.home>
Message-ID: <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Roman Zippel wrote:
> 
> So why not add the missing atomic_sub_and_test() (using simply 
> atomic_sub_return)?

sparc and s390 are not the only arches lacking atomic_sub_and_test.

Go ahead and send the patches changing all the arches that have it to
define __ARCH_HAS_ATOMIC_SUB_AND_TEST, and add asm-generic/atomic.h
for those that don't etc; but to me that seems like a waste of time -
unless Zam convinces us that Reiser4 will need every last ounce of
cpu on this particular line of code.

Hugh

