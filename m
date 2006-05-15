Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWEOSoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWEOSoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWEOSoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:44:05 -0400
Received: from colin.muc.de ([193.149.48.1]:4624 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750723AbWEOSoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:44:04 -0400
Date: 15 May 2006 20:44:01 +0200
Date: Mon, 15 May 2006 20:44:01 +0200
From: Andi Kleen <ak@muc.de>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Segfault on the i386 enter instruction
Message-ID: <20060515184401.GA89194@muc.de>
References: <44676F42.7080907@aknet.ru> <20060515074019.GA33242@muc.de> <4468B733.7010101@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4468B733.7010101@aknet.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 09:15:31PM +0400, Stas Sergeev wrote:
> Hi.
> 
> Andi Kleen wrote:
> >>Aren't the rlimit and the other checks of acct_stack_growth()
> >>not enough, or am I missing something obvious?
> >Traditionally Linux doesn't have a stack ulimit.
> That clarifies the roots of this %esp check, as without
> the stack ulimit and without the proper memory accounting
> (the case of 2.4?) such a check is the "last hope" - I've
> got the point. But are there the reasons to still keep it
> in 2.6, considering also the false-positives? It seems to
> have the STACK_RLIMIT and it seems to get the memory accounting
> right, and not too many arches seem to have such a check even.

Linux doesn't have a STACK_RLIMIT by default no.
It is set by a few distributions (for use with flexmmap) in PAM, but
not by all. The kernel defaults don't have it.

-Andi
