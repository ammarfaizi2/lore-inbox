Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWDYUhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWDYUhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWDYUhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:37:47 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:31755 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932302AbWDYUhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:37:46 -0400
Message-ID: <444E8895.8040404@argo.co.il>
Date: Tue, 25 Apr 2006 23:37:41 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Bongani Hlope <bonganilinux@mweb.co.za>
CC: Matt Keenan <matt.keenan@btinternet.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <444DCDB8.4070807@argo.co.il> <444DE678.4040805@btinternet.com> <200604252229.36533.bonganilinux@mweb.co.za>
In-Reply-To: <200604252229.36533.bonganilinux@mweb.co.za>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 20:37:44.0384 (UTC) FILETIME=[1B067400:01C668A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope wrote:
> To enable stack unwinding for exception handling, extra exception-related 
> information about each function needs to be available for each stack frame. 
> This information describes which destructors need to be called (so that local 
> objects can be cleaned up), indicates whether the current function has a try 
> block, and lists which exceptions the associated catch clauses can handle.
>
> Take a look at a typical OOPS trace and tell me if that will fit in a 4k stack 
> with C++ and stack unwinding.
>
>   
C++ on Linux does not put any information on the stack for exception 
handling purposes. Windows implementations do that but (a) I think the 
Windows kernel has a 12K stack (b) Linux is unlikely to use the 
Microsoft C++ compiler.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

