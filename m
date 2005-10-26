Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVJZPty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVJZPty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 11:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVJZPty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 11:49:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:28592 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964790AbVJZPtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 11:49:53 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: DIE_GPF vs. DIE_PAGE_FAULT/DIE_TRAP
Date: Wed, 26 Oct 2005 17:50:44 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <435FB26B.76F0.0078.0@novell.com> <200510261701.52611.ak@suse.de> <435FBB1A.76F0.0078.0@novell.com>
In-Reply-To: <435FBB1A.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261750.44501.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 17:21, Jan Beulich wrote:
 
> Hmm, then this isn't really useful for a debugger. There ought to be a
> chance to filter exceptions early (i.e. debugger accesses to non-mapped
> memory or non-existing MSRs) and a chance to detect bad faults (note
> that the kernel normal exception recovery mechanism may not be usable
> here because for example page faults first try to service the fault
> before scanning the fixup tables, but a debugger will normally not want
> a page-in to happen behind its back). I thought the latter was what gets
> reported as DIE_OOPS, while the former would be the filtering occasions
> (and I actually took the "grossly misnamed" comment in asm/kdebug.h as
> additional indication for that).

All you want is a hook early in GPF, right? I guess that should be ok.
I can see that it's useful on x86-64 due to the non canonical address 
fault resulting in GPFs mess. 

Just send a patch.

-Andi
