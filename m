Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVDEIeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVDEIeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDEId6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:33:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19595 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261675AbVDEIco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:32:44 -0400
Date: Tue, 5 Apr 2005 10:30:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405083001.GA28068@elte.hu>
References: <20050405000524.592fc125.akpm@osdl.org> <425240C5.1050706@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <425240C5.1050706@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:

> Andrew Morton a écrit :
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
> 
> Hi Andrew,
> 
> printk timing seems broken.
> It always shows [ 0.000000] on my Compaq Evo N600c.

could you send the full bootlog (starting at the 'gcc...' line)? I'm not 
sure whether TSC calibration was done on your CPU. If cyc2ns_scale is 
not set up then sched_clock() will return 0, and this could result in 
that printk symptom.

	Ingo
