Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUATXJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUATXJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:09:48 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:7808 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265898AbUATXJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:09:46 -0500
Date: Wed, 21 Jan 2004 00:08:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: swsusp does not stop DMA properly during resume
Message-ID: <20040120230842.GB1234@elf.ucw.cz>
References: <20040120224653.GA19159@elf.ucw.cz> <20040120150629.6949eda7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120150629.6949eda7.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > As Ben pointed out, swsusp is not doing the right thing with devices
> > in 2.6.1. I had patch for a long time here, and it needs to go
> > in... It stops them before copying pages back, so there are no issues
> > with running DMAs etc.
> 
> I _think_ what this patch is doing is suspending all devices from within
> the boot kernel before starting into the resumed kernel.  Is this
> correct?

Yes.

> > +	update_screen(fg_console);	/* Hmm, is this the problem? */
> 
> Cryptic comment.  To what "problem" does this refer?

Ugh, I am afraid I forgot waht this one means. I was seing some data
corruption but that was solved...

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
