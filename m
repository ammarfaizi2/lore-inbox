Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVDLLzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVDLLzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVDLLvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:51:36 -0400
Received: from orb.pobox.com ([207.8.226.5]:4499 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262368AbVDLLuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:50:51 -0400
Date: Tue, 12 Apr 2005 04:50:41 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Nathan Scott <nathans@sgi.com>, "Barry K. Nathan" <barryn@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hare@suse.de, linux-xfs@oss.sgi.com
Subject: Re: [xfs-masters] swsusp vs. xfs [was Re: 2.6.12-rc2-mm1]
Message-ID: <20050412115040.GA14008@ip68-4-98-123.oc.oc.cox.net>
References: <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net> <20050410212747.GB26316@elf.ucw.cz> <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net> <20050410230053.GD12794@elf.ucw.cz> <20050411043124.GA24626@ip68-4-98-123.oc.oc.cox.net> <20050411105759.GB1373@elf.ucw.cz> <20050411231213.GD702@frodo> <20050411235110.GA2472@elf.ucw.cz> <20050412002603.GA1178@frodo> <20050412110425.GA3063@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412110425.GA3063@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 01:04:25PM +0200, Pavel Machek wrote:
> > OK, so if that doesn't help, here's an alternate approach - this
> > lets xfsbufd track when its entering the refrigerator(), so that
> > other callers know that attempts to wake it are futile.
> 
> Thanks, this patch helped.

I can confirm, the 2nd patch worked and the 1st one didn't. (This is
against 2.6.12-rc2-mm1 with sched-x86-patch-name-is-way-too-long.patch
backed out. ;) )

-Barry K. Nathan <barryn@pobox.com>

