Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWERMBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWERMBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 08:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWERMBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 08:01:03 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:11700
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750869AbWERMBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 08:01:01 -0400
Message-Id: <446C7E61.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 18 May 2006 14:02:09 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] Re: [PATCH 2/3] reliable stack trace support
	(x86-64)
References: <4469FC22.76E4.0078.0@novell.com> <200605161905.11907.ak@suse.de> <446C5C6E.76E4.0078.0@novell.com> <200605181220.46037.ak@suse.de>
In-Reply-To: <200605181220.46037.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Three instructions?  We might be still able to afford that.
>
>push/pop is probably not needed because the stack frame will be already
>set up (ok possibly after a few instructions, but a small window might be 
>tolerable)

Okay, then I'll prepare a patch to that effect during the next couple of days.

>Maybe I'm dense but I still don't get - frame has a pt_regs so why 
>isn't the caller allowed to know about that fact?

Because the fact that there is a regs fields and the PC is accessible through it is architecture specific, yet the
caller (kernel/unwind.c) ought to be architecture independent.

Jan
