Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUHIIss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUHIIss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266359AbUHIIqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:46:48 -0400
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:12672 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266357AbUHIIqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:46:17 -0400
Date: Mon, 9 Aug 2004 10:46:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: highmem handling again
Message-ID: <20040809084603.GD737@elf.ucw.cz>
References: <20040808192300.GA659@elf.ucw.cz> <1092040054.28673.9.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092040054.28673.9.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I agree that swsusp_free is not the right place to restore_highmem(),
> > but I can't find "right" place to do it... Best I could come up is
> > with is:
> > 
> > It did not work at the end of swsusp_resume, or at the end of
> > swsusp_restore, IIRC.
> 
> I'm doing: copy back lowmem, restore local processor context, flush
> local tlb, restore highmem, allow other processors to restore their
> processor contexts and flush local tlbs. It works fine here.

Yes, I'd like to do the same, I just have problems finding that place
in new structure.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
