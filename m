Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVAWDT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVAWDT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 22:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVAWDT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 22:19:26 -0500
Received: from news.suse.de ([195.135.220.2]:32474 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261165AbVAWDTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 22:19:23 -0500
Date: Sun, 23 Jan 2005 04:19:21 +0100
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Matt Mackall <mpm@selenic.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/12] random pt4: Create new rol32/ror32 bitops
Message-ID: <20050123031921.GA1660@wotan.suse.de>
References: <200501222113_MC3-1-940A-5393@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501222113_MC3-1-940A-5393@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 09:10:40PM -0500, Chuck Ebbert wrote:
> On Fri, 21 Jan 2005 at 15:41:06 -0600 Matt Mackall wrote:
> 
> > Add rol32 and ror32 bitops to bitops.h
> 
> Can you test this patch on top of yours?  I did it on 2.6.10-ac10 but it
> should apply OK.  Compile tested and booted, but only random.c is using it
> in my kernel.

Does random really use variable rotates? For constant rotates 
gcc detects the usual C idiom and turns it transparently into
the right machine instruction.

If that's the case I would use it because it'll avoid some messy 
code everywhere.

-Andi
