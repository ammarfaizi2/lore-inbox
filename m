Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUJXUDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUJXUDp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUJXUDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:03:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:5596 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261600AbUJXUBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:01:51 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Robert Love <rml@novell.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098508238.13176.17.camel@krustophenia.net>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
Content-Type: text/plain
Date: Sun, 24 Oct 2004 16:02:12 -0400
Message-Id: <1098648132.5843.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 01:10 -0400, Lee Revell wrote:

> OK, thanks.  Still no answer to my original question though.
> 
> JACK makes extensive use of microsecond-level timers.  These must be
> calibrated at startup, and recalibrated when the CPU speed changes.  How
> does JACK register with the kernel to be notified when the CPU speed
> changes?

Ignoring all of these meta-issues like whether or not JACK actually
should be checking the CPU speed: Yes, I think that doing a kevent tied
to the processor object when the speed changes is an absolutely ideal
use of the kernel event layer.

HAL would use it, too.

	Robert Love


