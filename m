Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbTIIGkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 02:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTIIGkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 02:40:18 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:32008 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261987AbTIIGkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 02:40:15 -0400
Date: Tue, 9 Sep 2003 07:40:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [Patch] asm workarounds in generic header files
Message-ID: <20030909074012.A29521@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Siddha, Suresh B" <suresh.b.siddha@intel.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>
References: <A609E6D693908E4697BF8BB87E76A07A022114BC@fmsmsx408.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <A609E6D693908E4697BF8BB87E76A07A022114BC@fmsmsx408.fm.intel.com>; from suresh.b.siddha@intel.com on Mon, Sep 08, 2003 at 06:04:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 06:04:40PM -0700, Siddha, Suresh B wrote:
> Intel ecc compiler doesn't support inline assembly. 
> Attached patch is required to enable linux kernel build with Intel ecc compiler.
> Please apply.

No.  Currently kernel is supposed to be GNU C.  Using C89/C99 constructs
instead of GCCisms is fine and a good idea where it makes code more readable
and doesn't degrade performace.  Adding hacks for propritary compilers is
a very bad idea.

I can't see how you can compile the kernel with theses few changes without
inline assembly anyway..

Could you try to test your RELOC_HIDE version with various gcc versions
and maybe as some gcc gurus whether it's fine?  It would defintily fall
into category (1) above.  You'd need to come up with something nicer for
barrier(), though..

