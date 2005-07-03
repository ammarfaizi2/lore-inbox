Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVGCM3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVGCM3R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 08:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVGCM3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 08:29:17 -0400
Received: from silver.veritas.com ([143.127.12.111]:10360 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261401AbVGCM3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 08:29:13 -0400
Date: Sun, 3 Jul 2005 13:30:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Denis Vlasenko <vda@ilport.com.ua>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "cutaway@bellsouth.net" <cutaway@bellsouth.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: function ordering (was: Re: [RFC] exit_thread() speedups in x86
 process.c)
In-Reply-To: <1120391140.3164.39.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0507031323280.6427@goblin.wat.veritas.com>
References: <200507012258_MC3-1-A340-3A81@compuserve.com> 
 <200507021456.40667.vda@ilport.com.ua> <1120391140.3164.39.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Jul 2005 12:29:13.0007 (UTC) FILETIME=[D1CF43F0:01C57FCA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2005, Arjan van de Ven wrote:
> 
> hmm. I wonder if a slightly different approach (based on the __slow)
> idea would make sense
> 1) Use -ffunction-sections option from gcc to put each function in it's
> own section
> 2) Use readprofile/oprofile data to collect an (external to the code)
> list of hot/cold functions (we can put a default list in the kernel
> source somewhere and allow people to measure their own if they want)
> 3) Use this list to make a linker script to order the functions
> 
> this way we don't need to put a lot of __slow's in the code *and* it's
> based on measurements not assumptions, and can be tuned for a specific
> situation in addition.

This is reminiscent of "fur", whose source Old SCO opened.
Google for SCO fur: amidst all the hits about "fur flying"
you might find something useful!

Hugh
