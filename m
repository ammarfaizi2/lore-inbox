Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269405AbUIYUdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269405AbUIYUdX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269406AbUIYUdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 16:33:23 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:37569 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269405AbUIYUdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 16:33:22 -0400
Date: Sat, 25 Sep 2004 22:35:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: [Patch] no exec: i386 and x86_64 fixes
Message-ID: <20040925203507.GA27913@elte.hu>
References: <20040924154644.B25742@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924154644.B25742@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Suresh Siddha <suresh.b.siddha@intel.com> wrote:

>   * An executable for which elf_read_implies_exec() returns TRUE will
>   * have the READ_IMPLIES_EXEC personality flag set automatically.
>   */
> -#define elf_read_implies_exec_binary(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
> +#define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))

yeah, we noticed this a couple of days ago and the fix is in BK already
(post 2.6.9-rc2 commit).

	Ingo
