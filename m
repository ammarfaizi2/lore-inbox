Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUINLex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUINLex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUINLdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:33:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56717 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269302AbUINL2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:28:35 -0400
Date: Tue, 14 Sep 2004 13:28:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched: fix scheduling latencies in mttr.c
Message-ID: <20040914112847.GA2804@elte.hu>
References: <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914110611.GA32077@elte.hu>
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


fix scheduling latencies in the MTRR-setting codepath.
Also, fix bad bug: MTRR's _must_ be set with interrupts disabled!

	Ingo
