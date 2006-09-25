Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWIYOug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWIYOug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWIYOug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:50:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26309 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750725AbWIYOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:50:35 -0400
Subject: Re: Pb with simultaneous SATA and ALSA I/O
From: Lee Revell <rlrevell@joe-job.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Dominique Dumont <domi.dumont@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       alsa-user <alsa-user@lists.sourceforge.net>
In-Reply-To: <20060925143838.GQ13641@csclub.uwaterloo.ca>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <20060925143838.GQ13641@csclub.uwaterloo.ca>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 10:50:59 -0400
Message-Id: <1159195859.2899.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 10:38 -0400, Lennart Sorensen wrote:
> Well i agree with the suggestion of trying a different PCI slot for
> the sb live.  There is so much onboard stuff sharing interrupts on
> those boards that you might have problems because of that.  Creative
> cards are not very good at dealing with anything other than ideal
> conditions from what I have gathered over the years.  The manual for
> the board will tell you which IRQ goes to which slot, and I guess you
> want to avoid using a slot that shares with the SATA controller. 

It might not be interrupt related, it could be DMA starvation.  This has
been observed with some SATA controllers while testing the -rt patches.
The symptom is that the latency traces show the machine going in "slow
motion".

Dominique: try the -rt kernel, enable latency tracing and post the
output.

Lee

