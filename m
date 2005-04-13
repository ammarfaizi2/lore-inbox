Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVDMSU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVDMSU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDMSU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:20:29 -0400
Received: from colin2.muc.de ([193.149.48.15]:16908 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S261166AbVDMSUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:20:20 -0400
Date: 13 Apr 2005 20:20:19 +0200
Date: Wed, 13 Apr 2005 20:20:19 +0200
From: Andi Kleen <ak@muc.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 072/198] x86_64: Use a VMA for the 32bit vsyscall
Message-ID: <20050413182019.GA50241@muc.de>
References: <200504121031.j3CAVnpl005415@shell0.pdx.osdl.net> <20050412170230.GD2758@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412170230.GD2758@granada.merseine.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	/* MAYWRITE to allow gdb to COW and set breakpoints */
> > +	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYEXEC|VM_MAYWRITE;
> 
> Any reason for VM_MAYEXEC to be specified twice? did you mean something else?

No reason, must have been a typo. Anyways, it is correct, just redundant.

I will clean it up in a future patch. Thanks.

-Andi
