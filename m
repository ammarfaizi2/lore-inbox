Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVAUK00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVAUK00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVAUKXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:23:00 -0500
Received: from cantor.suse.de ([195.135.220.2]:27843 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262326AbVAUKUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:20:04 -0500
Date: Fri, 21 Jan 2005 11:19:58 +0100
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: hugang@soulinfo.com, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050121101958.GB6291@wotan.suse.de>
References: <200501202032.31481.rjw@sisk.pl> <20050120205950.GF468@openzaurus.ucw.cz> <200501202246.38506.rjw@sisk.pl> <20050121022348.GA18166@hugang.soulinfo.com> <20050121100422.GC18373@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121100422.GC18373@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +copyback_page:
> > +	movq	24(%rax), %r9
> > +	xorl	%r8d, %r8d
> > +
> 
> Are you sure %r8 and %r9 are caller-saved? I'd use low registers if I
> were you, they look nincer and generate shorter opcodes ;-).

They are.

-Andi
