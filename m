Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTIJQYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTIJQYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:24:03 -0400
Received: from trained-monkey.org ([209.217.122.11]:27908 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S265165AbTIJQXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:23:37 -0400
To: davidm@hpl.hp.com
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] asm workarounds in generic header files
References: <A609E6D693908E4697BF8BB87E76A07A022114C0@fmsmsx408.fm.intel.com>
	<m3llsxivva.fsf@trained-monkey.org>
	<16222.14136.21774.211178@napali.hpl.hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 10 Sep 2003 12:22:37 -0400
In-Reply-To: <16222.14136.21774.211178@napali.hpl.hp.com>
Message-ID: <m3d6e8ipf6.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

[trimmed the CC list since this is more at the preference level]

David> In my opinion, moving all the asm-stuff greatly improved
David> readability of the source code.  Especially for folks who are
David> not intimately familiar with GCC asm syntax (which is hairy
David> _and_ platform-specific).

Hi David,

I think this really depends on what you are trying to debug. If you
expect the macros to do exactly what they are described to be doing
then I'd agree. However every so often when you look up the macros you
really want to look at the details what they are actually doing or
even compare them to another arch's implementation to make sure they
are behaving the same. At least thats my experience.

I personally think it's unrealistic to think one can try and debug
things in include/asm without being able to read the assembly output
in the first place.

David> I think the jury is out on this one.  Clearly it's a huge
David> benefit if you can make do without inline asm.  GCC has to make
David> lots of worst-case assumptions whenever it encounters an asm
David> statement and, due to macros and inlining, the asm statements
David> are not just hidden in a few leaf routines.

Reducing the amount of inline asm in the kernel would be a good
thing. It is cetainly one of those things that have been abused way
beyond it's intent.

Cheers,
Jes
