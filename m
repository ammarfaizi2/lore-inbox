Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUJAUqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUJAUqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUJAUl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:41:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:37767 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266561AbUJAUk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:40:26 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
In-Reply-To: <87k6ubcccl.fsf@sulphur.joq.us>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
	 <1096581213.24868.19.camel@krustophenia.net>
	 <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net>
	 <87k6ubcccl.fsf@sulphur.joq.us>
Content-Type: text/plain
Message-Id: <1096663225.27818.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 16:40:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 00:05, Jack O'Quin wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> > This uses the basic rlimits infrastructure.  You can manage it manually
> > in a shell with ulimit -l, or you can use pam (pam_limits) to configure
> > per uid limits.  There's a pam doc that describes limits, and a manpage
> > for ulimit.  It's really easy to use, and should eliminate the need for
> > the mlock part of that module.
> 
> Thanks for the pointer, Chris.
> 
> I'll see if I can figure out a way to make that useable for musicians.
> 
> The ulimit approach is way too cumbersome.

Agreed.  The whole point of getting realtime-lsm in the kernel is to
make it _easier_ to get a linux audio (or other realtime system) up and
running.  Would it be feasible to use rlimits to let users run
SCHED_FIFO processes?  The ulimit approach would probably be acceptable
if it subsumed all the functionality of the realtime-lsm module.

Lee

