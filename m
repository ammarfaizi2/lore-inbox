Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVCGWoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVCGWoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCGWnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:43:05 -0500
Received: from colin2.muc.de ([193.149.48.15]:55054 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261824AbVCGVxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:53:01 -0500
Date: 7 Mar 2005 22:53:00 +0100
Date: Mon, 7 Mar 2005 22:53:00 +0100
From: Andi Kleen <ak@muc.de>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] NMI/CMOS RTC race fix for x86-64
Message-ID: <20050307215300.GA36024@muc.de>
References: <422CA1FA.1010903@acm.org> <m1ll8zmfzc.fsf@muc.de> <422CBE9F.1090906@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422CBE9F.1090906@acm.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >But in this case it isnt. Instead of all this complexity 
> >just remove the NMI reassert code from the NMI handler.
> >It is oudated and mostly useless on modern systems anyways.
> > 
> >
> "mostly useless" and "completely useless" are two different things.

It's completely useless (double checked the AMD8111 and ICH5 data sheets)

There is nothing that should ever clear the NMI bit in this register.
In fact the ICH5 datasheet even explicitely says software should
never touch this bit. 

It may have some meaning in ancient ISA chipsets, but that is 
of no concern on x86-64.

> Do you want me to submit a patch that simply removes this?

Yes, please.

-Andi
