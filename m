Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUBHFpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 00:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUBHFpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 00:45:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28102 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262228AbUBHFpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 00:45:19 -0500
Date: Sun, 8 Feb 2004 05:45:15 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jon Foster <jon@jon-foster.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Message-ID: <20040208054515.GE21151@parcelfarce.linux.theplanet.co.uk>
References: <40258A16.5060905@jon-foster.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40258A16.5060905@jon-foster.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 01:00:06AM +0000, Jon Foster wrote:
> I agree with Viro that the best solution would be if there was some way
> to tell GCC that the inline assembly doesn't return - probably by attaching
> __attribute__((noreturn)) to it.

That __attribute__ would have to go with __asm__ - it should tell gcc
that insn has no successors.  And that would be a PITA to deal with
- gcc parser is not a thing of beauty as it is, so changing it would
not be fun.

Easier to express that as an asm constraint - then it will have no impact
on the high-level parser and constraint parser is simple enough...
