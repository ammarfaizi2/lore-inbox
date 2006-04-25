Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWDYVIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWDYVIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWDYVIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:08:40 -0400
Received: from mail-03.jhb.wbs.co.za ([196.2.97.2]:10832 "EHLO
	mail-03.jhb.wbs.co.za") by vger.kernel.org with ESMTP
	id S1751258AbWDYVIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:08:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAOoqTkSIbQEKDio
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: Compiling C++ modules
Date: Tue, 25 Apr 2006 23:08:42 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <200604252229.36533.bonganilinux@mweb.co.za> <444E8895.8040404@argo.co.il>
In-Reply-To: <444E8895.8040404@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604252308.42847.bonganilinux@mweb.co.za>
X-Original-Subject: Re: Compiling C++ modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 22:37, Avi Kivity wrote:
> Bongani Hlope wrote:
> > To enable stack unwinding for exception handling, extra exception-related
> > information about each function needs to be available for each stack
> > frame. This information describes which destructors need to be called (so
> > that local objects can be cleaned up), indicates whether the current
> > function has a try block, and lists which exceptions the associated catch
> > clauses can handle.
> >
> > Take a look at a typical OOPS trace and tell me if that will fit in a 4k
> > stack with C++ and stack unwinding.
>
> C++ on Linux does not put any information on the stack for exception
> handling purposes. Windows implementations do that but (a) I think the
> Windows kernel has a 12K stack (b) Linux is unlikely to use the
> Microsoft C++ compiler.

Cool thanx, I see that g++ (3,x) uses Dwarf2 to store the frame info. Unlike 
Microsoft.

---
    Choose the right tools, use them the right way. 
     Refuse to compromise, expect  to succeed, 
                      Then start again.
