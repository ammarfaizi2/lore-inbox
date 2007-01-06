Return-Path: <linux-kernel-owner+w=401wt.eu-S932215AbXAFVE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbXAFVE1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 16:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbXAFVE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 16:04:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40863 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215AbXAFVEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 16:04:24 -0500
Date: Sat, 6 Jan 2007 13:04:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Marcus Meissner <meissner@suse.de>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@codemonkey.org.uk>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: revert PIE randomization?
In-Reply-To: <Pine.LNX.4.64.0701062005001.22171@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0701061303320.3661@woody.osdl.org>
References: <Pine.LNX.4.64.0701062005001.22171@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jan 2007, Hugh Dickins wrote:
> 
> Isn't that randomization, anywhere from 0x10000 to ELF_ET_DYN_BASE,
> sure to place the ET_DYN from time to time just where the comment says
> it's trying to avoid?  I assume that somehow results in the error reported.

Hmm.. It's certainly the case that it would appear that the randomization 
might put the binary just under the heap, and cause conflicts with brk 
and the mmap heap.

You're right. I'm inclined to just revert it, modulo some comments from 
others. Marcus?

		Linus
