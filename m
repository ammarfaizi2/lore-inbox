Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUEXTMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUEXTMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbUEXTMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:12:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43916 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264677AbUEXTMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:12:38 -0400
Date: Mon, 24 May 2004 23:13:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAP_POPULATE prot 0
Message-ID: <20040524211355.GA16165@elte.hu>
References: <Pine.LNX.4.44.0405242003270.27145-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405242003270.27145-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugh Dickins <hugh@veritas.com> wrote:

> It seems eccentric to implement MAP_POPULATE only on PROT_NONE
> mappings: do_mmap_pgoff is passing down prot, then
> sys_remap_file_pages verifies it's not set.  I guess that's an
> oversight from when we realized that the prot arg to
> sys_remap_file_pages was misdesigned.

yeah.

> There's another oddity whose heritage is harder for me to understand,
> so please let me leave it to you: sys_remap_file_pages is declared as
> asmlinkage in mm/fremap.c, but is the one syscall declared without
> asmlinkage in include/linux/syscalls.h.

i think that's just an oversight.

	Ingo
