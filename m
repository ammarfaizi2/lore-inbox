Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266258AbUFPML6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUFPML6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266260AbUFPML5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:11:57 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:62848 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S266258AbUFPMLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:11:41 -0400
Date: Wed, 16 Jun 2004 14:11:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] make ps2 mouse work ...
Message-ID: <20040616121149.GA9325@ucw.cz>
References: <20040615191023.G28403@mvista.com> <20040615205611.1e9cbfcc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615205611.1e9cbfcc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 08:56:11PM -0700, Andrew Morton wrote:

> > I found this problem on a MIPS machine.  The problem is 
> > likely to happen on other register-rich RISC arches too.
> > 
> > cmdcnt needs to be volatile since it is modified by
> > irq routine and read by normal process context.
> 
> volatile is not the preferred way to fix this up.  This points at either a
> locking error in the psmouse driver or a missing "memory" thingy in the
> mips port somewhere.
> 
> Please describe the bug which led to this patch.  Where was it getting stuck?

My current BK tree has this fixed using atomic bitfields, which do
compilation and memory barriers. I plan to sync it to Linus post 2.6.7.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
