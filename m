Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUAaJZL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 04:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUAaJZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 04:25:10 -0500
Received: from ns.suse.de ([195.135.220.2]:26539 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263584AbUAaJZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 04:25:06 -0500
Date: Sat, 31 Jan 2004 10:24:59 +0100
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, michael@mvdavid.com
Subject: Re: raid6 badness
Message-Id: <20040131102459.37b8929d.ak@suse.de>
In-Reply-To: <401B421F.4060104@zytor.com>
References: <Pine.LNX.4.58.0401301158340.8900@sapphire.newearth.org.suse.lists.linux.kernel>
	<bvf2vl$6pr$1@terminus.zytor.com.suse.lists.linux.kernel>
	<p73ad44n7ig.fsf@verdi.suse.de>
	<401B421F.4060104@zytor.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004 21:50:23 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Andi Kleen wrote:
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > 
> >>I don't know what would cause the stack to be misaligned, however.
> > 
> > x86-64 kernel doesn't guarantee the stack to be 16 byte aligned
> > (although it usually is). If you need 16 byte alignment you have 
> > to align yourself.
> > 
> 
> OK, that's unfortunate... per our discussion I really think this is a 
> bug, since the compiler still does 16-byte alignment, and thus we're 
> taking the cost without the benefit.

I disagree on the "bug" part. I will check with the compiler guys, but 
as long as gcc doesn't rely on 16 byte alignment I will rather just disable it 
in the compiler.

I don't see much sense in enforcing this just because of some obscure SSE2
function that can align itself. Saving instructions and stack space
would be more important.

-Andi
