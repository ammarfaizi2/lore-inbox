Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUGBCoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUGBCoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 22:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUGBCoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 22:44:34 -0400
Received: from holomorphy.com ([207.189.100.168]:5563 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266386AbUGBCod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 22:44:33 -0400
Date: Thu, 1 Jul 2004 19:44:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] hugetlb MAP_PRIVATE mapping vs /dev/zero
Message-ID: <20040702024422.GG21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <40E43BDE.85C5D670@tv-sign.ru> <20040702012012.GC5937@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702012012.GC5937@zax>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 08:29:18PM +0400, Oleg Nesterov wrote:
>> We can fix hugetlbfs_file_mmap() or read_zero_pagealigned()
>> or both.

On Fri, Jul 02, 2004 at 11:20:12AM +1000, David Gibson wrote:
> Err... surely we need to fix both, yes?

No. /dev/zero is innocent. hugetlb is demanding VM_SHARED semantics
without actually setting VM_SHARED. /dev/zero tripping over its
nonstandard pagetable structure is not something to be dealt with
in /dev/zero itself.


-- wli
