Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUJZEIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUJZEIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbUJZEHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:07:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59579 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262079AbUJZEF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:05:57 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098626510.24073.9.camel@localhost.localdomain>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
	 <1098566366.24804.8.camel@localhost.localdomain>
	 <1098571334.29081.21.camel@krustophenia.net>
	 <1098626510.24073.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 00:05:56 -0400
Message-Id: <1098763556.9166.22.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 15:02 +0100, Alan Cox wrote:
> You've got a good 48Khz or so clock
> in the audio device too so many games clock off the audio clock anyway.

This is OK for a game or mplayer but this is not 100% reliable, we need
to know if we missed an interrupt or didn't get scheduled in time.  If
it were there would be no such thing as an xrun.  For serious audio work
we want an xrun to be a fatal error.

For 2.6 it looks like sched_clock, the HPET, and maybe the PM timer may
do what we want, if the syscall overhead is tolerable.

Lee 

