Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWBUUx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWBUUx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWBUUx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:53:56 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12503
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932551AbWBUUx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:53:56 -0500
Date: Tue, 21 Feb 2006 12:50:33 -0800 (PST)
Message-Id: <20060221.125033.34277159.davem@davemloft.net>
To: davej@redhat.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: softlockup interaction with slow consoles
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060221202757.GB24159@redhat.com>
References: <200602212105.38075.ak@suse.de>
	<20060221.121948.60060362.davem@davemloft.net>
	<20060221202757.GB24159@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Tue, 21 Feb 2006 15:27:57 -0500

> On Tue, Feb 21, 2006 at 12:19:48PM -0800, David S. Miller wrote:
>  > From: Andi Kleen <ak@suse.de>
>  > Date: Tue, 21 Feb 2006 21:05:37 +0100
>  > 
>  > > The classic way is to just use touch_nmi_watchdog() somewhere
>  > > in the loop that does work. That touches the softwatchdog too
>  > > these days.
>  > 
>  > "jiffies" aren't advancing, since interrupts are disabled by
>  > release_console_sem(), so that doesn't work.
>  > 
>  > I tried that already :-)
> 
> Where did you put it?  I hit a similar problem a few months back,
> and this patch did the trick for me..

Not the NMI watchdog, the softlockup watchdog.
