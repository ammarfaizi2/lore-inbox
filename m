Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWHMGuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWHMGuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 02:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWHMGuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 02:50:09 -0400
Received: from ns.suse.de ([195.135.220.2]:19116 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750720AbWHMGuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 02:50:08 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH for review] [43/145] i386: Redo semaphore and rwlock assembly helpers
Date: Sun, 13 Aug 2006 08:50:01 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
References: <20060810 935.775038000@suse.de> <20060810193557.7E1F313B90@wotan.suse.de> <20060812175348.79175355.akpm@osdl.org>
In-Reply-To: <20060812175348.79175355.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608130850.01592.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 02:53, Andrew Morton wrote:
> On Thu, 10 Aug 2006 21:35:57 +0200 (CEST)
> Andi Kleen <ak@suse.de> wrote:
> 
> > - Move them to a pure assembly file. Previously they were in 
> > a C file that only consisted of inline assembly. Doing it in pure
> > assembler is much nicer.
> > - Add a frame.i include with FRAME/ENDFRAME macros to easily
> > add frame pointers to assembly functions 
> > - Add dwarf2 annotation to them so that the new dwarf2 unwinder
> > doesn't get stuck on them
> > [TBD: needs review from someone who knows more about CFA than me, e.g. Jan]
> > - Random cleanups
> 
> This patch causes the below crash after some seconds of disk stresstesting.

I can't reproduce this with either LTP nor OraSim.
Also I looked over the patch and i can't see any mistakes.

Can you double check please?

-Andi


> 
