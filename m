Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTJDHDL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 03:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTJDHDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 03:03:11 -0400
Received: from zero.aec.at ([193.170.194.10]:7181 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261923AbTJDHDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 03:03:10 -0400
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
From: Andi Kleen <ak@muc.de>
Date: Sat, 04 Oct 2003 09:02:59 +0200
In-Reply-To: <CFYv.787.23@gated-at.bofh.it> (Joe Korty's message of "Fri, 03
 Oct 2003 23:50:19 +0200")
Message-ID: <m34qyp7ae4.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <CFYv.787.23@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> writes:

>  
> I do not believe that the above constitutes a correct fix.  The
> problem is that follow_pages() is fundamentally not able to handle a
> mapping which does not have a 'struct page' backing it up, and a
> mapping to IO memory by definition has no 'struct page' structure to
> back it up.

The 2.4 vm scanner handles this by always checking VALID_PAGE().

Maybe follow_pages() should do that too?

-Andi
