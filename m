Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWHMGyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWHMGyM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 02:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWHMGyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 02:54:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:12676 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750723AbWHMGyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 02:54:11 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH for review] [108/145] x86_64: Some preparationary cleanup for stack trace
Date: Sun, 13 Aug 2006 08:53:45 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193706.8DDA613C0B@wotan.suse.de> <20060812232645.6ae8121c.akpm@osdl.org>
In-Reply-To: <20060812232645.6ae8121c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608130853.45626.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 08:26, Andrew Morton wrote:
> On Thu, 10 Aug 2006 21:37:06 +0200 (CEST)
> Andi Kleen <ak@suse.de> wrote:
> 
> > - Remove unused all_contexts parameter 
> > No caller used it
> 
> s390 does and now it's busted.

I had actually undone this later because all_contexts == 0 fixed
the previously commented out i386-stacktrace-unwinder (= use dwarf2
unwinder for i386 lockdep). So should be ok now on firstfloor.

-Andi
