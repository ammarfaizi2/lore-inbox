Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUJDKP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUJDKP7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 06:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUJDKPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 06:15:53 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:55744 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267928AbUJDKPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 06:15:44 -0400
Date: Mon, 4 Oct 2004 12:17:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Message-ID: <20041004101711.GA21029@elte.hu>
References: <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <1096785457.1837.0.camel@krustophenia.net> <1096786248.1837.4.camel@krustophenia.net> <1096787179.1837.8.camel@krustophenia.net> <20041003195725.GA31882@elte.hu> <1096851180.16648.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096851180.16648.2.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Here is an almost identical one (it's even exactly 507 usecs!).  This
> and the one I sent previously were apparently caused by switching from
> X to a text console and back. 

ah, it's the VGA console:

> Sep  2 16:13:49 krustophenia kernel:  [_mmx_memcpy+314/384] _mmx_memcpy+0x13a/0x180
> Sep  2 16:13:49 krustophenia kernel:  [vgacon_save_screen+120/128] vgacon_save_screen+0x78/0x80
> Sep  2 16:13:49 krustophenia kernel:  [redraw_screen+411/560] redraw_screen+0x19b/0x230

now i'm wondering why that's running with preemption disabled - i
thought we fixed that.

	Ingo
