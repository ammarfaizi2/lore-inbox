Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTIJRCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTIJRCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:02:45 -0400
Received: from palrel11.hp.com ([156.153.255.246]:12993 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265276AbTIJRCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:02:42 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16223.22832.21582.762891@napali.hpl.hp.com>
Date: Wed, 10 Sep 2003 10:02:40 -0700
To: Jes Sorensen <jes@wildopensource.com>
Cc: davidm@hpl.hp.com, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] asm workarounds in generic header files
In-Reply-To: <m3d6e8ipf6.fsf@trained-monkey.org>
References: <A609E6D693908E4697BF8BB87E76A07A022114C0@fmsmsx408.fm.intel.com>
	<m3llsxivva.fsf@trained-monkey.org>
	<16222.14136.21774.211178@napali.hpl.hp.com>
	<m3d6e8ipf6.fsf@trained-monkey.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 10 Sep 2003 12:22:37 -0400, Jes Sorensen <jes@wildopensource.com> said:

  Jes> I think this really depends on what you are trying to debug. If
  Jes> you expect the macros to do exactly what they are described to
  Jes> be doing then I'd agree. However every so often when you look
  Jes> up the macros you really want to look at the details what they
  Jes> are actually doing or even compare them to another arch's
  Jes> implementation to make sure they are behaving the same. At
  Jes> least thats my experience.

That's true for some, but not others.  For example, I'd say that
things like getreg() and setreg() are pretty intuitive.

  Jes> I personally think it's unrealistic to think one can try and
  Jes> debug things in include/asm without being able to read the
  Jes> assembly output in the first place.

Assembly output != GCC asm statements.  There are lots of
assembly-savy folks that have no clue how to read/interpret the GCC
asm syntax.  Those folks have the option of either generating an
assembly file or disassembling the resulting object file.  Both
approaches would let them read the resulting code without having to
know exactly how the asm statement (or intrinsic) works.

  David> I think the jury is out on this one.  Clearly it's a huge
  David> benefit if you can make do without inline asm.  GCC has to
  David> make lots of worst-case assumptions whenever it encounters an
  David> asm statement and, due to macros and inlining, the asm
  David> statements are not just hidden in a few leaf routines.

  Jes> Reducing the amount of inline asm in the kernel would be a good
  Jes> thing. It is cetainly one of those things that have been abused
  Jes> way beyond it's intent.

Agreed.

	--david
