Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUGZU7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUGZU7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUGZU6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:58:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47015 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266065AbUGZUp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:45:59 -0400
Date: Mon, 26 Jul 2004 22:47:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch] voluntary-preempt-2.6.8-rc2-J7
Message-ID: <20040726204720.GA26561@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726124059.GA14005@elte.hu>
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


i've uploaded -J7:

   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-J7

Changes since -J4:

- fix the latency that occurs when a large number of files are deleted: 
  the guilty one is select_parent() - this should fix the Bonnie latency 
  reported by Lee Revell.

[ the ones below add conditional reschedule points that dont affect 
  users who have kernel_preemption turned on:]

- fix /proc/PID/maps latencies

- fix latencies triggered by 'df' on a large filesystem

- fix exec() latency when dealing with large environments

- add might_sleep() to lock_buffer()

	Ingo
