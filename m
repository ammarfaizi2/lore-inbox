Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUJONS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUJONS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUJONS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:18:27 -0400
Received: from zeus.kernel.org ([204.152.189.113]:990 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267259AbUJONS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:18:26 -0400
Date: Fri, 15 Oct 2004 14:15:07 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: __attribute__((unused))
In-Reply-To: <20041015123300.GA12530@janus>
Message-ID: <Pine.LNX.4.58L.0410151412510.11787@blysk.ds.pg.gda.pl>
References: <20041014220243.B28649@flint.arm.linux.org.uk> <20041015123300.GA12530@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Frank van Maarseveen wrote:

> This makes sense, assuming the gcc info pages are correct:
> `unused'
>      This attribute, attached to a function, means that the function is
>      meant to be possibly unused.  GCC will not produce a warning for
>      this function.  GNU C++ does not currently support this attribute
>      as definitions without parameters are valid in C++.
> 
> `used'
>      This attribute, attached to a function, means that code must be
>      emitted for the function even if it appears that the function is
>      not referenced.  This is useful, for example, when the function is
>      referenced only in inline assembly.
> 
> So, a function could be "used" and "unused" at the same time:
> 
> 	unused -> don't warn
> 	used -> don't discard

 Except that "used" already implies no warning as it makes the function 
not unused anymore.

  Maciej
