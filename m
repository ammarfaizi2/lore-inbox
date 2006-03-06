Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752419AbWCFT6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbWCFT6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbWCFT6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:58:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752419AbWCFT6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:58:43 -0500
Date: Mon, 6 Mar 2006 14:58:18 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Shinichi Kudo <randomshinichi4869@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA C3 (Ezra C5C) Crashes with longhaul Freq scaling
Message-ID: <20060306195818.GF15971@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Shinichi Kudo <randomshinichi4869@gmail.com>,
	linux-kernel@vger.kernel.org
References: <8be2e100603040646k7f40e8eai391eb914040cb8f8@mail.gmail.com> <20060305043800.GA2253@redhat.com> <1141674250.26548.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141674250.26548.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 07:44:10PM +0000, Alan Cox wrote:
 > On Sad, 2006-03-04 at 23:38 -0500, Dave Jones wrote:
 > > There's an ugly patch below that was submitted, which fixes it for
 > > some people, but as it's a) ide specific, and b) completely the
 > > wrong place to do this and c) racy,  I never merged it to mainline.
 > 
 > If I understand the documentation correctly you simply need to disable
 > the master bit on the root bridge during the transition and the PCI
 > transactions will be stalled, providing you don't take too long about
 > it.

tried it, didn't change anything.

The current code goes one step further, and disables it for all devices.
Still no joy.  See the do_powersaver() function in arch/i386/kernel/cpu/cpufreq/longhaul.c

		Dave

-- 
http://www.codemonkey.org.uk
