Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267520AbUG2Wrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbUG2Wrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUG2Wo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:44:57 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:21633 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267517AbUG2WmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:42:10 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091117407.2521.3.camel@teapot.felipe-alfaro.com>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
	 <1091054194.8867.26.camel@laptop.cunninghams>
	 <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
	 <1091061983.8867.95.camel@laptop.cunninghams>
	 <1091095341.4359.0.camel@teapot.felipe-alfaro.com>
	 <1091103080.2703.6.camel@desktop.cunninghams>
	 <1091117407.2521.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1091140772.2703.38.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 30 Jul 2004 08:39:32 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-30 at 02:10, Felipe Alfaro Solana wrote:
> > Okay. So, just to make sure I understand you correctly, suspending works
> > fine with all of these other patches added and adding the extra
> > refrigerator calls breaks it. Are you at all able to narrow it down to a
> > particular change?
> 
> Exactly! I'm currently running a highly patched kernel based on 2.6.8-
> rc2-bk7 plus Con's work and Ingo's voluntary preempt. They work fine
> when suspending to memory (S3) and to disk (S4 via swsusp), but adding
> your kthread freezer flags to the mix keeps my CardBus NIC from being
> recognized when resuming from S3: I need to unplug it, then plug it to
> make it functional again.
> 
> However, I'm not sure what causes this behavior.

Could you please try reversing each of the changes in my patch until it
starts working?  The NFS ones could be done all at once - they should be
irrelevant to you anyway IIRC.

Regards,

Nigel

