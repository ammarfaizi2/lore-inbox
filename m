Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVDOU07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVDOU07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDOU07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:26:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:17309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbVDOUZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:25:37 -0400
Date: Fri, 15 Apr 2005 13:25:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Daniel Souza <thehazard@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Igor Shmukler <igor.shmukler@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
Message-ID: <20050415202528.GF23013@shell0.pdx.osdl.net>
References: <6533c1c905041511041b846967@mail.gmail.com> <1113588694.6694.75.camel@laptopd505.fenrus.org> <6533c1c905041512411ec2a8db@mail.gmail.com> <e1e1d5f40504151251617def40@mail.gmail.com> <6533c1c905041512594bb7abb4@mail.gmail.com> <e1e1d5f40504151310467d16bd@mail.gmail.com> <1113596014.6694.87.camel@laptopd505.fenrus.org> <e1e1d5f4050415131977a776e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f4050415131977a776e9@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Souza (thehazard@gmail.com) wrote:
> No, I was tracking file creations/modifications/attemps of
> access/directory creations|modifications/file movings/program
> executions with some filter exceptions (avoid logging library loads by
> ldd to preserve disk space).
> 
> It was a little module that logs file changes and program executions
> to syslog (showing owner,pid,ppid,process name, return of
> operation,etc), that, used with remote syslog logging to a 'strictly
> secure' machine (just receive logs), keep security logs of everything
> (like, it was possible to see apache running commands as "ls -la /" or
> "ps aux", that, in fact, were signs of intrusion of try of intrusion,
> because it's not a usual behavior of httpd. Maybe anyone exploited a
> php page to execute arbitrary scripts...)

This is what the audit subsystem is working towards.  Full tracking
isn't quite there yet, but getting closer.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
