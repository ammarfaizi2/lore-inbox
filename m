Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbULQCvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbULQCvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 21:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbULQCvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 21:51:43 -0500
Received: from holomorphy.com ([207.189.100.168]:16592 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262726AbULQCvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 21:51:33 -0500
Date: Thu, 16 Dec 2004 18:51:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
Message-ID: <20041217025127.GP771@holomorphy.com>
References: <20041213020319.661b1ad9.akpm@osdl.org> <20041215113515.GJ771@holomorphy.com> <20041215034239.2d2f9d9d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215034239.2d2f9d9d.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  This appears to have trouble on em64t; not only does the following happen,
>>  but some odd userspace programs (e.g. ssh) appear to be failing.
>> 
>>  Shutting down powersaved                                                       cut here ] --------- [please bite here ] ---------
>>  KDdoneernel BUG at pageattr:156

On Wed, Dec 15, 2004 at 03:42:39AM -0800, Andrew Morton wrote:
> I can't say I'm surprised, really, although it booted and did stuff OK on my
> box.
> There's a mangled-up mess of ioremap/pageattr patches from Andrea and Andi
> in there.  I'll drop a few things.  We need to go through those changes a
> little more carefully.

The odd userspace programs failing are far more disturbing. They
suggest COW or something of similar gravity is broken on x86-64
by some new patch. The ioremap/pageattr issues are merely some
shutdown-time oops, which is rather minor in comparison, although
reported far more verbosely.


-- wli
