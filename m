Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760339AbWLFJBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760339AbWLFJBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760341AbWLFJBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:01:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48844 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760338AbWLFJBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:01:16 -0500
Date: Wed, 6 Dec 2006 10:00:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] add ignore_loglevel boot option
Message-ID: <20061206090026.GB28160@elte.hu>
References: <20061205120954.GA30154@elte.hu> <20061205144709.9c50194d.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205144709.9c50194d.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <randy.dunlap@oracle.com> wrote:

> > sometimes the kernel prints something interesting while userspace 
> > bootup keeps messages turned off via loglevel. Enable the printing 
> > of /all/ kernel messages via the "ignore_loglevel" boot option. Off 
> > by default.
> 
> Hi,
> 
> Is this equivalent to using the "debug" kernel parameter except that 
> userspace (init scripts) cannot muck it up (modify the setting)?

yeah.

> I've seen init scripts modify the loglevel, much to my dismay.

yeah - i once lost a few hours of debugging to such an incident.

> I'd say that this is useful, but it's really userspace that needs to 
> be fixed.

well, loglevel /can/ be managed by userspace, and sometimes an important 
kernel message might have a too high loglevel. Also, sometimes the 
kernel does spurious messages during hardware detect, etc., so userspace 
naturally wants to prevent them from going to the console. So it's 
really a mix of a problem and i wouldnt put the blame on user-space. 
User-space used the only control they have to fix the situation.

	Ingo
