Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUJBHwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUJBHwA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 03:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUJBHwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 03:52:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:50667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267326AbUJBHv5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 03:51:57 -0400
Date: Sat, 2 Oct 2004 00:49:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jaakko =?ISO-8859-1?B?SHl25HR0aQ==?= <jaakko@hyvatti.iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-Id: <20041002004938.175203ba.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410021038060.25679@gyre.weather.fi>
References: <20040922131210.6c08b94c.akpm@osdl.org>
	<Pine.LNX.4.58.0410021038060.25679@gyre.weather.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaakko Hyvätti <jaakko@hyvatti.iki.fi> wrote:
>
> On Wed, 22 Sep 2004, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/
> ...
> > - Found (and fixed) the bug which was causing those
> >   ext3-goes-readonly-under-load problems.  It was in the new wait/wakeup code.
> 
> Forgive me for asking a question that probably enough research would
> answer, but which exact patch of those listed does fix this problem?  I
> cannot find the right one myself, and I would like to just address this
> problem that has haunted me at least since 2.6.6, I guess.  Or is the fix
> too interdependent with other changes?

It was wait_on_bit-must-loop.patch.

But that simply fixes a bug which was introduced into an earlier
2.6.9-rcX-mmY kernel.  The bug is certainly not present in any Linus
kernel, nor in any 2.6.6/7/8 kernel.

So you're seeing something different.  Please send a full report.
