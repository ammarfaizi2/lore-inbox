Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWEPJca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWEPJca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 05:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWEPJca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 05:32:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:58570 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751710AbWEPJc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 05:32:29 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Segfault on the i386 enter instruction
Date: Tue, 16 May 2006 11:32:18 +0200
User-Agent: KMail/1.9.1
Cc: Stas Sergeev <stsp@aknet.ru>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200605152231_MC3-1-BFDF-12B4@compuserve.com>
In-Reply-To: <200605152231_MC3-1-BFDF-12B4@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161132.18610.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 04:29, Chuck Ebbert wrote:
> In-Reply-To: <44676F42.7080907@aknet.ru>
> 
> On Sun, 14 May 2006 21:56:18 +0400, Stas Sergeev wrote:
> 
> > Andi Kleen wrote:
> > > Handling it like you expect would require to disassemble 
> > > the function in the page fault handler and it's probably not 
> > > worth doing that for this weird case.
> > Just wondering, is this case really that weird?
> > In fact, the check against %esp that the kernel
> > does, looks strange. I realize that it can catch a
> > (very rare) user-space bug of accessing below %esp, but
> > other than that it looks redundant (IMHO) and as soon as
> > it triggers the false-positives, what is it really good for?
> 
> I can't get a SIGSEGV on any native i386 kernel, not even when
> running on AMD64.  It only happens on native x86_64 kernels.

I reproduced the original SIGSEGV on several i386 kernels.

> Intel says nothing about a write check.  Is that a mistake in the manual
> or is that something only AMD64 does, and then only in long mode?

In 98+% of all cases when Intel and AMD documentation differ
in subtle detail it's a documentation bug.

-Andi
 
