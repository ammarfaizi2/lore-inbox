Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUFXCCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUFXCCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 22:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUFXCCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 22:02:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:31640 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263735AbUFXCCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 22:02:48 -0400
Date: Wed, 23 Jun 2004 19:01:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-Id: <20040623190150.4a182cfc.akpm@osdl.org>
In-Reply-To: <20040624015229.GP1552@holomorphy.com>
References: <20040623223146.GG1552@holomorphy.com>
	<20040623153758.40e3a865.akpm@osdl.org>
	<20040623230730.GJ1552@holomorphy.com>
	<20040623163819.013c8585.akpm@osdl.org>
	<20040624000308.GK1552@holomorphy.com>
	<20040623171818.39b73d52.akpm@osdl.org>
	<20040624002651.GL1552@holomorphy.com>
	<20040624003249.GM1552@holomorphy.com>
	<20040623180722.69a8ea6f.akpm@osdl.org>
	<20040624012435.GN1552@holomorphy.com>
	<20040624015229.GP1552@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Also, you mentioned at one point extending committed memory accounting
>  to account for unreclaimable pages (the term you suggested). Would you
>  also like that to be looked into? It might take longer than overnight
>  to brew up, mostly due to testing turnaround.

Well let's see how the patch ends up looking.

I have bad feelings about the overcommit logic - several times we have
accidentally noticed (and fixed) gross inaccuracies in it, and I am sure
others remain.

I am not aware of anyone getting down and explicitly testing it in lots of
different scenarios (including mlock), and perhaps it gets inaccurate when
zone fallbacks are involved.

If you're prepared to undertake that level of thinking and coverage testing
and fix up the fallout, that would certainly be good.  If you think it's
worth the effort, and, again, depending upon the performance and ickiness
impact of the patches.
