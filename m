Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269703AbUJMTsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269703AbUJMTsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 15:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJMTsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 15:48:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:9905 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269785AbUJMThk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 15:37:40 -0400
Date: Wed, 13 Oct 2004 21:35:58 +0200
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@novell.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 4level page tables for Linux
Message-Id: <20041013213558.43b3236c.ak@suse.de>
In-Reply-To: <20041013184153.GO17849@dualathlon.random>
References: <20041012135919.GB20992@wotan.suse.de>
	<1097606902.10652.203.camel@localhost>
	<20041013184153.GO17849@dualathlon.random>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 20:41:53 +0200
Andrea Arcangeli <andrea@novell.com> wrote:


> 
> after you add the 4level, locking will become necessary for the pgd, but
> it's still not needed for the pml4.

Yes, agreed. I did an audit of the generic code and it seems to be ok
regarding the pgd use.


> peraphs we could consider pgd4 instead of pml4. What does "pml" stands
> for?

page mapping level 4 (?) just guessing here.

PML4 is the name AMD and Intel use in their documentation. I don't see 
a particular reason to be different from them.

-Andi
