Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbTDWOQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTDWOQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:16:12 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5096 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S264051AbTDWOQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:16:07 -0400
Date: Wed, 23 Apr 2003 15:57:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wanted: A decent assembler
In-Reply-To: <200304230906_MC3-1-35A3-DF4@compuserve.com>
Message-ID: <Pine.GSO.3.96.1030423153532.6238C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Chuck Ebbert wrote:

>    "The result of an expression must be an absolute number, or else an
> offset into a particular section.  If an expression is not absolute,
> and there is not enough information when `as' sees the expression to
> know its section, a second pass over the source program might be
> necessary to interpret the expression--but the second pass is currently
> not implemented.  `as' aborts with an error message in this situation."

 But:

    `-'
          "Subtraction".  If the right argument is absolute, the result
          has the section of the left argument.  If both arguments are
          in the same section, the result is absolute.  You may not
          subtract arguments from different sections.

> 1:	pushl $vector-256		# 5-byte instruction
> 	jmp common_interrupt		# 2 or 5 bytes (8 or 32-bit offset)
> 2:
> if 2b-1b > 8			# <============================= ERROR
> 	irq_align=16			# switch to 16-byte alignment
> endif

 This is a bug in gas.  Please check if it is reproducible with the latest
release (2.13.2.1) and if so, then file a bug report to
<bug-binutils@gnu.org>.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

