Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264268AbUEaLxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbUEaLxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUEaLxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:53:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43702 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264268AbUEaLxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:53:01 -0400
Date: Mon, 31 May 2004 13:52:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@osdl.org>, ncunningham@linuxmail.org,
       cef-lkml@optusnet.com.au, linux-kernel@vger.kernel.org, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040531115259.GC28188@atrey.karlin.mff.cuni.cz>
References: <200405280000.56742.rob@landley.net> <20040529222308.GA1535@elf.ucw.cz> <20040531031743.0d7566e3.akpm@osdl.org> <200405310638.21015.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405310638.21015.rob@landley.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > btw, software suspend wrecks your swap partition if you suspend to swap but
> > do not resume from swap - you need to run mkswap again.  Seems odd.
> 
> I think it's intentional, so that if you you boot to a different kernel swapon 
> -a won't automount the swap partition and hork your saved image.

Actually, we *want* to hork that saved image, because it is extremely
dangerous to resume from it.

We also want to kill suspend signature ASAP, so that if driver kills
resume and user presses reset, we will not try to resume again and
fail in exactly same way.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
