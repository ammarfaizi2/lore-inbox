Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269203AbUJFK5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269203AbUJFK5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269205AbUJFK5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:57:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35518 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269203AbUJFK5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:57:42 -0400
Date: Wed, 6 Oct 2004 12:57:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Pasi Savolainen <psavo@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-ID: <20041006105754.GA2585@elte.hu>
References: <Pine.LNX.4.44.0410051251210.6757-100000@localhost.localdomain> <Pine.LNX.4.44.0410061138400.5936-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410061138400.5936-100000@localhost.localdomain>
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


* Hugh Dickins <hugh@veritas.com> wrote:

> Yes, that _raw_read_trylock patch has fixed my zombie problem: since
> 2.6.9-rc2-mm1 my repeated kernel builds would hang after several
> hours, with a zombie (usually cc1) on one cpu and its waiting parent
> (usually gcc) on another, with the puzzle of why the parent had never
> got woken - because do_wait's read_lock(&tasklist_lock) went ahead
> even while exit_notify held the write lock.

great, thanks for tracking this down!

	Ingo
