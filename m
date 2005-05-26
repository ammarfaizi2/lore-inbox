Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVEZQa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVEZQa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVEZQa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:30:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8644 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261599AbVEZQ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:27:48 -0400
Subject: Re: [patch] enable PREEMPT_BKL on !PREEMPT+SMP too
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050526111742.GA18272@elte.hu>
References: <20050526111742.GA18272@elte.hu>
Content-Type: text/plain
Date: Thu, 26 May 2005 12:27:46 -0400
Message-Id: <1117124867.6261.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 13:17 +0200, Ingo Molnar wrote:
> It might introduce
> performance regressions as well, if any performance-critical code uses
> the BKL heavily and gets overscheduled due to the semaphore. I very much
> hope there is no such performance-critical codepath left though.

A write-intensive benchmark on a reiser3 FS is probably a good place to
start testing.

Lee

