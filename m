Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbUJWWW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUJWWW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 18:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUJWWW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 18:22:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:7810 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261322AbUJWWWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 18:22:18 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098508238.13176.17.camel@krustophenia.net>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098566366.24804.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 23 Oct 2004 22:19:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-23 at 06:10, Lee Revell wrote:
> JACK makes extensive use of microsecond-level timers.  These must be
> calibrated at startup, and recalibrated when the CPU speed changes.  How
> does JACK register with the kernel to be notified when the CPU speed
> changes?

It did

- The kernel doesn't always know
- CPU speed is meaningless in hyper-threading since performance is not
x2 for two cores but instead varies
- It doesn't handle split CPU speed SMP - where CPU speeds vary
- God help you if virtualised

