Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVJaWKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVJaWKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVJaWKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:10:51 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48321 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964865AbVJaWKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:10:51 -0500
Subject: Re: any fairness in NTPL pthread mutexes?
From: Lee Revell <rlrevell@joe-job.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1130781965.32101.63.camel@mindpipe>
References: <43665B08.6040005@nortel.com>
	 <1130781965.32101.63.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 17:09:20 -0500
Message-Id: <1130796561.32101.81.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 13:06 -0500, Lee Revell wrote:
> On Mon, 2005-10-31 at 11:57 -0600, Christopher Friesen wrote:
> > I'm using NPTL.
> > 
> > If I have a pthread mutex currently owned by a task, and two other tasks 
> > try to lock it, when the mutex is unlocked, are there any rules about 
> > the order in which the waiting tasks get the mutex (ie priority, FIFO, 
> > etc.)?
> 
> I believe it's currently FIFO in violation of POSIX which specifies
> priority based wakeup.  AIUI one of the main goals of the realtime &
> robust mutexes work is to fix this.

Sorry this is wrong - the current behavior is allowed by POSIX for
SCHED_OTHER but not SCHED_FIFO or _RR.

Lee

