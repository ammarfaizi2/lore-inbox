Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWCAWac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWCAWac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCAWac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:30:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbWCAWab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:30:31 -0500
Date: Wed, 1 Mar 2006 14:32:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: tbm@cyrius.com, linux-kernel@vger.kernel.org,
       Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-Id: <20060301143231.6f88a80a.akpm@osdl.org>
In-Reply-To: <20060301194759.GA1879@elf.ucw.cz>
References: <20060226100518.GA31256@flint.arm.linux.org.uk>
	<20060226021414.6a3db942.akpm@osdl.org>
	<20060227141315.GD2429@ucw.cz>
	<20060228101713.6fd44027.akpm@osdl.org>
	<20060228220128.GA4254@unjust.cyrius.com>
	<20060228153256.64f4781d.akpm@osdl.org>
	<20060301171046.GA4024@flint.arm.linux.org.uk>
	<20060301194759.GA1879@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > > 
> > > >From my reading of the above thread, putting the proposed workaround into
> > > serial core will indeed allow people's machines to keep running while
> > > reminding us about the driver bugs.
> > 
> > I would much rather the buggy drivers were actually fixed - is there a
> > reason why the drivers can't actually be fixed (other than lazyness)?
> > 
> > Once they're fixed, adding a BUG_ON then becomes practical IMHO - it'll
> > stop new driver writers being confused.
> 
> Okay, but lets add BUG_ONs that actually work. BUG_ON in second hunk
> could never trigger, and last hunk did not help in specific case of
> bluetooth problem. This should be better: it warns at right places,
> but allows system to survive.

I like that approach, thanks.

> I'll now try to fix bluetooth problem.

Please keep Marcel Cc'ed.

> +		return -EL3HLT;

ooh, I always wanted to use that ;)
