Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWDFTqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWDFTqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 15:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWDFTqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 15:46:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:35214 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932173AbWDFTqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 15:46:02 -0400
Subject: Re: [PATCH 2/4] coredump: speedup SIGKILL sending
From: Lee Revell <rlrevell@joe-job.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060406220628.GA237@oleg>
References: <20060406220628.GA237@oleg>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 15:45:58 -0400
Message-Id: <1144352758.2866.105.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 02:06 +0400, Oleg Nesterov wrote:
> With this patch a thread group is killed atomically under ->siglock.
> This is faster because we can use sigaddset() instead of force_sig_info()
> and this is used in further patches.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Won't this cause huge latencies when a process with lots of threads is
killed?

Lee

