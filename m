Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUKNNTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUKNNTH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUKNNTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:19:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:28371 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261297AbUKNNTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:19:04 -0500
Date: Sun, 14 Nov 2004 13:49:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gunther Persoons <gunther_persoons@spymac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041114124932.GB11042@elte.hu>
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <41951380.2080801@spymac.com> <20041112201936.GA15133@elte.hu> <41961C03.10607@spymac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41961C03.10607@spymac.com>
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


* Gunther Persoons <gunther_persoons@spymac.com> wrote:

> As i thought the init scripts were my problem. But i have an other
> question. I recently started to use NFS. But with the mainline kernel
> cpu usage is 100%, and when i look in top si shows bewteen 40 and 60%
> cpu usage. With your kernel si is 0%, but ksoftriqd/0 shows around 38%
> cpu usage and total cpu usage is around 52%. Is this normal? on my
> server cpu usage is 2% but it uses a intel network card. My laptop is
> using a wireless pcmcia card (cisco).

normally the RT kernel has higher system overhead (all IRQ traffic goes
to separate thread contexts, involving context-switching, etc.) so a
_reduction_ in system overhead looks a bit strange. Is there a
difference in performance?

	Ingo
