Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266461AbUHBKTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUHBKTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUHBKTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:19:07 -0400
Received: from holomorphy.com ([207.189.100.168]:22699 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266461AbUHBKSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:18:49 -0400
Date: Mon, 2 Aug 2004 03:18:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-timing-on-2.6.8-rc2-O2
Message-ID: <20040802101840.GB2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040730064431.GA17777@elte.hu> <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe> <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com> <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe> <20040802073938.GA8332@elte.hu> <1091435237.3024.9.camel@mindpipe> <20040802092855.GA15894@elte.hu> <20040802100815.GA18349@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802100815.GA18349@elte.hu>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 12:08:15PM +0200, Ingo Molnar wrote:
> i've uploaded a new version of the patch, this solves a problem when
> using a smaller than 1000 usecs threshold: idle time got accounted as
> delay too which flooded the log. The new patch makes idle=poll the
> default and that function calls touch_preempt_timing().

Sorry about not updating things, but there's also another bug, which is
that touch_preempt_timing() forgets to check if the threshold has been
violated in the interim.


-- wli
