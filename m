Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266583AbUGKMnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266583AbUGKMnS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 08:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUGKMnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 08:43:17 -0400
Received: from colin2.muc.de ([193.149.48.15]:19721 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266583AbUGKMnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 08:43:10 -0400
Date: 11 Jul 2004 14:43:07 +0200
Date: Sun, 11 Jul 2004 14:43:07 +0200
From: Andi Kleen <ak@muc.de>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: serious performance regression due to NX patch
Message-ID: <20040711124307.GA88881@muc.de>
References: <2giKE-67F-1@gated-at.bofh.it> <2gIc8-6pd-29@gated-at.bofh.it> <2gJ8a-72b-11@gated-at.bofh.it> <2gJhY-776-21@gated-at.bofh.it> <m31xjiam9q.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0407110754280.26194@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407110754280.26194@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 07:56:10AM -0400, Ingo Molnar wrote:
> 
> On Sun, 11 Jul 2004, Andi Kleen wrote:
> 
> > > +#ifdef __i386__
> > 
> > Won't do on x86-64.
> 
> well on x86-64 'non-executable' really means non-executable, and always
> did, right? (and this is completely separate from the issue of whether the
> process stack is executable or not. This is about x86 that didnt enforce
> the vma's protection bit.)

Not quite - there is 32bit emulation. And the 64bit version also doesn't
do NX by default, but also relies on ELF header bits for this.

-Andi
