Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269155AbUINDu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269155AbUINDu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269167AbUINDuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:50:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4770 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269147AbUINDqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:46:14 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Chris Wright <chrisw@osdl.org>, kronos@kronoz.cjb.net,
       linux-kernel <linux-kernel@vger.kernel.org>, joq@io.com, torbenh@gmx.de
In-Reply-To: <20040914030126.GV9106@holomorphy.com>
References: <20040912155035.GA17972@dreamland.darkstar.lan>
	 <1095117752.1360.5.camel@krustophenia.net>
	 <20040913163448.T1973@build.pdx.osdl.net>
	 <1095128285.1752.4.camel@krustophenia.net>
	 <20040914030126.GV9106@holomorphy.com>
Content-Type: text/plain
Message-Id: <1095133574.1752.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Sep 2004 23:46:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 23:01, William Lee Irwin III wrote:
> On Mon, 2004-09-13 at 19:34, Chris Wright wrote:
> >> The mlock() bit is unecessary now.  Use rlimits on the audio users.
> >> Which leaves realtime bits, plus others.  I had a more generic module
> >> (per-capability) that would be a superset of this.  Perhaps that's a
> >> better fit.  I'm travelling this week, so forgive the spotty replies.
> 
> On Mon, Sep 13, 2004 at 10:18:06PM -0400, Lee Revell wrote:
> > I think this would be fine.  All we need is a way to allow users to run
> > SCHED_FIFO processes and use mlockall() without being root and without
> > having to patch the kernel.  It's a pretty simple requirement.
> 
> Please construct a entitlement/permission checking scheme for this that
> is not so lax as removing permissions checks altogether conditionally
> on some sysctl.

This is how it works now.  You would typically do 'modprobe realtime
gid=29' and add audio users to that group.  How is this any less secure
than the traditional user/group/other permissions model?

Lee

