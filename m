Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbUKIOa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUKIOa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUKIOa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:30:27 -0500
Received: from mx1.elte.hu ([157.181.1.137]:22733 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261518AbUKIOaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:30:22 -0500
Date: Tue, 9 Nov 2004 16:32:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] little schedule() cleanup: use cached current value
Message-ID: <20041109153212.GA28986@elte.hu>
References: <4190ADD7.CE7EFB7C@tv-sign.ru> <20041109124553.GA25663@elte.hu> <4190D3D8.B7512745@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4190D3D8.B7512745@tv-sign.ru>
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


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Ingo Molnar wrote:
> 
> > nack. We switch the kernel stack in switch_to() so 'next' here
> > is the old task we switched to before we went off the CPU.
> 
> yes, sorry. here is corrected patch.
> 
> schedule() can use prev instead of get_current().
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
