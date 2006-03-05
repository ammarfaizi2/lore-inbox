Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWCEXhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWCEXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:37:25 -0500
Received: from kanga.kvack.org ([66.96.29.28]:23460 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751077AbWCEXhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:37:25 -0500
Date: Sun, 5 Mar 2006 18:32:02 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: memory range R/W triggered breakpoints in kernel ?
Message-ID: <20060305233202.GD20768@kvack.org>
References: <aec8d6fc0603050900w7aa1f93due29e9c1cf87e9316@mail.gmail.com> <20060305231654.GB20768@kvack.org> <aec8d6fc0603051531o622d04bdjf2993729b0b946ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec8d6fc0603051531o622d04bdjf2993729b0b946ca@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 12:31:29AM +0100, Mateusz Berezecki wrote:
> Yes but again this is userspace. I was thinking about solution used
> back in the old days in SoftICE kernel level debugger.
> It had a BPR command (breakpoint on range) which could monitor
> up to 400000 bytes of memory range. Unfortunately for me this command
> works in very old versions of _that_ other OS.

If it is in userspace, then you don't need anything from the kernel.  
mprotect() and catch the resulting SIGSEGV.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
