Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVAGR31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVAGR31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVAGR31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:29:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:10673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261358AbVAGR3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:29:21 -0500
Date: Fri, 7 Jan 2005 09:29:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Martin Mares <mj@ucw.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107092918.B2357@build.pdx.osdl.net>
References: <20050107162902.GA7097@ucw.cz> <200501071636.j07Gateu018841@localhost.localdomain> <20050107170603.GB7672@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050107170603.GB7672@ucw.cz>; from mj@ucw.cz on Fri, Jan 07, 2005 at 06:06:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Mares (mj@ucw.cz) wrote:
> Hello!
> 
> > They are present but disabled by default. You have to hack the initial
> > values of CAP_INIT_EFF_SET and CAP_INIT_IHN_SET.
> 
> Oops. Does anybody know why this has been done?

Yes, SETPCAP became a gaping security hole.  Recall the sendmail hole.

> Also, it seems that it has a relatively easy work-around: boot with
> init=/sbin/simple-wrapper and let the wrapper set the cap_bset and exec real
> init. (I agree that it's a hack, but a temporarily usable one.)

This won't work, you can't increase the bset, which is hardcoded to
leave out SETPCAP.  Also, init is hard coded to start without SETPCAP.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
