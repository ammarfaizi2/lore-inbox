Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVIILTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVIILTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVIILTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:19:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58064 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030241AbVIILTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:19:17 -0400
Date: Fri, 9 Sep 2005 13:19:15 +0200
From: Andi Kleen <ak@suse.de>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: Andi Kleen <ak@suse.de>, Jan Beulich <JBeulich@novell.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Message-ID: <20050909111909.GJ19913@wotan.suse.de>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <200509091054.11932.ak@suse.de> <43216EFB020000780002489B@emea1-mh.id2.novell.com> <200509091123.59205.ak@suse.de> <20050909110702.GA787@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909110702.GA787@zaniah>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 01:07:02PM +0200, Philippe Elie wrote:
> On Fri, 09 Sep 2005 at 11:23 +0000, Andi Kleen wrote:
> 
>  
> > Indeed. Someone must have fixed it.  But why would anyone want frame pointers
> > on x86-64?
> 
> Oprofile can use it, I though it was already used but apparently only
> to backtrace userspace actually.

You should be using dwarf2 unwind information instead. Near all
user space on x86-64 has it, and kernels sometimes too.

-Andi
