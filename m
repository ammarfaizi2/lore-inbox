Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUFCMKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUFCMKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUFCMKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:10:16 -0400
Received: from gprs214-234.eurotel.cz ([160.218.214.234]:18305 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263301AbUFCMIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:08:15 -0400
Date: Thu, 3 Jun 2004 14:08:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Rob Landley <rob@landley.net>, Andrew Morton <akpm@osdl.org>,
       cef-lkml@optusnet.com.au, linux-kernel@vger.kernel.org, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040603120803.GG31089@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net> <20040529222308.GA1535@elf.ucw.cz> <20040531031743.0d7566e3.akpm@osdl.org> <200405310638.21015.rob@landley.net> <20040531115259.GC28188@atrey.karlin.mff.cuni.cz> <40BC5E8C.3020509@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BC5E8C.3020509@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>btw, software suspend wrecks your swap partition if you suspend to swap 
> >>>but
> >>>do not resume from swap - you need to run mkswap again.  Seems odd.
> >>
> >>I think it's intentional, so that if you you boot to a different kernel 
> >>swapon -a won't automount the swap partition and hork your saved image.
> >
> >
> >Actually, we *want* to hork that saved image, because it is extremely
> >dangerous to resume from it.
> >
> >We also want to kill suspend signature ASAP, so that if driver kills
> >resume and user presses reset, we will not try to resume again and
> >fail in exactly same way.

> Suspend2 fixes the header and records when you've attempted to resume from 
> it. If you try a second time it gives you the option of invalidating the 
> image or trying to resume. Pavel, feel free to grab the code out of 
> suspend2 if you want.

It should be simpler to just move already-existing signature changing
code to right place, but thanks anyway.
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
