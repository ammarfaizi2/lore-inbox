Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286756AbSA1Vtp>; Mon, 28 Jan 2002 16:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSA1Vtf>; Mon, 28 Jan 2002 16:49:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55563 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286756AbSA1VtX>;
	Mon, 28 Jan 2002 16:49:23 -0500
Message-ID: <3C55C5C1.AF01CB3B@zip.com.au>
Date: Mon, 28 Jan 2002 13:42:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
In-Reply-To: <20020128153210.A3032@nevyn.them.org> <3C55BC89.EDE3105C@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
>  For your testing purposes you
> could just remove the VALID_PAGE() test in mm/memory.c:get_page_map(),
> and then gdb should be able to get at the framebuffer.
> 

Sorry, this won't work.  We'll just get a random page struct outside
mem_map[] and the kernel will die.
