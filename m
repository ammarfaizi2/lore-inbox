Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUGGOWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUGGOWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUGGOWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:22:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32708 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265137AbUGGOWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:22:11 -0400
Date: Wed, 7 Jul 2004 15:22:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: tom st denis <tomstdenis@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040707142210.GG12308@parcelfarce.linux.theplanet.co.uk>
References: <20040707030029.GD12308@parcelfarce.linux.theplanet.co.uk> <20040707111028.82649.qmail@web41111.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707111028.82649.qmail@web41111.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 04:10:28AM -0700, tom st denis wrote:
> > Pay attention to difference in the set of acceptable types for
> > decimal
> > and heaxdecimal constants.
> 
> You're f'ing kidding me right?  Dude, I write portable ISO C source
> code for a living.  My code has been built on dozens and dozens of
> platforms **WITHOUT** changes.  I know what I'm talking about.
> 
> 0x01, 1 are 01 all **int** constants.

Correct.  And irrelevant.

> On some platforms 0xdeadbeef may be a valid int

Correct, but incomplete.

> Before you step down to belittle others I'd suggest you actually make
> sure you're right.  

Always do.

Exercise:
	1) what type does an integer constant 0xdeadbeef have on a platform
with INT_MAX equal to 0x7fffffff and UINT_MAX equal to 0xffffffff?
	2) when does the situation differ for integer constant 3735928559?

Oh, and do read the part of C standard in question.  Hint: extra restrictions
are placed on decimal constants, not on the octals and hexadecimals.
