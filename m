Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161524AbWHDWGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161524AbWHDWGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161525AbWHDWGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:06:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14059 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161524AbWHDWGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:06:53 -0400
Date: Fri, 4 Aug 2006 18:06:44 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-ID: <20060804220644.GA28344@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andreas Schwab <schwab@suse.de>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801184451.GP22240@redhat.com> <1154470467.15540.88.camel@localhost.localdomain> <20060801223011.GF22240@redhat.com> <20060801223622.GG22240@redhat.com> <20060801230003.GB14863@martell.zuzino.mipt.ru> <20060801231603.GA5738@redhat.com> <jebqr4f32m.fsf@sykes.suse.de> <20060801235109.GB12102@redhat.com> <20060802001626.GA14689@redhat.com> <20060804141955.3139b20b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804141955.3139b20b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 02:19:55PM -0700, Andrew Morton wrote:
 > On Tue, 1 Aug 2006 20:16:26 -0400
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > In case where we detect a single bit has been flipped, we spew
 > > the usual slab corruption message, which users instantly think
 > > is a kernel bug.  In a lot of cases, single bit errors are
 > > down to bad memory, or other hardware failure.
 > > 
 > > This patch adds an extra line to the slab debug messages
 > > in those cases, in the hope that users will try memtest before
 > > they report a bug.
 > 
 > Well boy, this has to be the most-reviewed patch ever.  You'd think that
 > I'd apply it with great confidence and warm fuzzies.

I should stick to one-liner fixes.

 > - one decl per line is more patching-friendly and a bit more idiomatic.
 > - make `bad_count' an int: a uchar might overflow
 > - Put a blank line between decls and code
 > - rename `total' to `error', remove `errors'.
 > - there's no need to sum up the errors.
 > - don't need to check for non-zero `errors': we know it is != POISON_FREE.
 > - make it look non-crapful in an 80-col window.
 > - add missing spaces in arithmetic

With this much iteration, I do have one question..
Does it still work ? :-)

		Dave

-- 
http://www.codemonkey.org.uk
