Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUHAAZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUHAAZS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUHAAZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:25:17 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47540 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263772AbUHAAZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:25:11 -0400
Subject: Re: [Unichrome-devel] Dragging window in
	X	causes	soundcard	interrupts to be lost
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40FB0092.3070800@shipmail.org>
References: <1089952196.25689.7.camel@mindpipe>
	 <40F78D21.10305@shipmail.org>  <40F793C1.2080908@shipmail.org>
	 <1090001316.27995.3.camel@mindpipe>  <40F8298E.8080508@shipmail.org>
	 <1090010147.30435.2.camel@mindpipe> <1090107507.10795.1.camel@mindpipe>
	 <40FA3AEC.9050906@shipmail.org> <1090190244.22282.8.camel@mindpipe>
	 <40FB0092.3070800@shipmail.org>
Content-Type: text/plain
Message-Id: <1091319939.20819.67.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 20:25:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-18 at 18:58, Thomas Hellstrom wrote:
> Hi, Lee. 
> 
> Most of the code is inherited from VIA, but as far as I know, there
> are no locks held except the DRM lock when DRI is used, which it isn't
> in your case. 
> 

Thomas,

Do you have the original driver source from VIA handy?  This is looking
more and more like a hardware bug - 2D acceleration engine activity
causes interrupts from the PCI slot to be disabled for long periods. 
Maybe it disables interrupts to prevent other processes writing to the
shared video/system RAM as it DMAs.  I would like to verify that the
problem still occurs with their driver, before I try to convince them
there's a hardware issue with the EPIA boards.

On that note, assuming I verify the bug, does anyone have any
recommendations for getting VIA to take me seriously?  The problem is
very easy to reproduce.

Lee



