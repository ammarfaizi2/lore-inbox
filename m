Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWCNVfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWCNVfR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWCNVfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:35:16 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:12766 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932477AbWCNVfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:35:14 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Date: Wed, 15 Mar 2006 08:34:44 +1100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060314115145.GL10870@elf.ucw.cz> <1142357806.13256.140.camel@mindpipe>
In-Reply-To: <1142357806.13256.140.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603150834.45954.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 04:36, Lee Revell wrote:
> On Tue, 2006-03-14 at 12:51 +0100, Pavel Machek wrote:
> > "we have just
> > finished big&ugly memory trashing job, can we get our interactivity
> > back"? Like I'd probably cron-scheduled it just after updatedb
>
> The updatedb problem is STILL not solved?  I remember someone proposed
> years ago to have it use fcntl() or fadvise() to tell the kernel that we
> are about to read every file on the system and to please not wipe the
> cache - I guess this was never done?

There is an POSIX_FADV_DONTNEED (I think that's the one), but userspace needs 
updating to actually use it.

Cheers,
Con
