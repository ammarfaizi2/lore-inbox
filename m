Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUDNUFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUDNUFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:05:43 -0400
Received: from palrel11.hp.com ([156.153.255.246]:25564 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261606AbUDNUFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:05:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16509.39308.8764.219@napali.hpl.hp.com>
Date: Wed, 14 Apr 2004 13:05:32 -0700
To: Jamie Lokier <jamie@shareable.org>
Cc: davidm@hpl.hp.com, linux-ia64@linuxia64.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
In-Reply-To: <20040414192844.GD12105@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
	<20040414082355.GA8303@mail.shareable.org>
	<20040414113753.GA9413@mail.shareable.org>
	<16509.25006.96933.584153@napali.hpl.hp.com>
	<20040414184603.GA12105@mail.shareable.org>
	<16509.35554.807689.904871@napali.hpl.hp.com>
	<20040414192844.GD12105@mail.shareable.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 14 Apr 2004 20:28:44 +0100, Jamie Lokier <jamie@shareable.org> said:

  >>  I know why: back in those days, GCC emitted code for nested C
  >> functions that assumed an executable stack.  Also, Linus wasn't
  >> terribly eager to turn off execute-permission on data/stacks.
  >> Even on ia64 we started out that way, until I saw the error in my
  >> ways.

  Jamie> We're both wrong.

No, Alpha Linux didn't map data without execute permission.

  Jamie> What it doesn't have is write-only.

Yes, that one is because earlier Alphas couldn't do subword stores, so
WRITE-permission necessitated READ-permission.

	--david
