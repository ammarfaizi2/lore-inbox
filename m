Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUKZTzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUKZTzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUKZTy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:54:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262474AbUKZTbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:14 -0500
Date: Thu, 25 Nov 2004 15:48:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch, 2.6.10-rc2] floppy boot-time detection fix
Message-ID: <20041125144810.GA8160@elte.hu>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041124112745.GA3294@elte.hu> <21889.195.245.190.93.1101377024.squirrel@195.245.190.93> <20041125120133.GA22431@elte.hu> <20041125143337.GA32051@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125143337.GA32051@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> (this does not solve the irq threading related SMP lockup though, i'm
> attacking that problem next - now that my fd0 gets detected fine ;-) )

in fact, i cannot reproduce the SMP lockup anymore and the floppy works
just fine. Maybe the stale irq, even if detection went fine,
mis-programmed the controller, which ended up totally locking up upon
the first attempted IO?

	Ingo
