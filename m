Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVK1OU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVK1OU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 09:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVK1OU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 09:20:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53139 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751268AbVK1OU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 09:20:58 -0500
Date: Mon, 28 Nov 2005 15:21:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonas Oreland <jonas@mysql.com>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
Message-ID: <20051128142101.GA27172@elte.hu>
References: <1133179554.11491.3.camel@localhost.localdomain> <438AF860.7050905@mysql.com> <1133182780.5625.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133182780.5625.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=ALL_TRUSTED,AWL,MANY_EXCLAMATIONS,PLING_QUERY autolearn=no SpamAssassin version=3.0.3
	0.9 PLING_QUERY            Subject has exclamation mark and question mark
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 MANY_EXCLAMATIONS      Subject has many exclamations
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > Booting with idle=poll, fixes that.
> > 
> > Hope it help
> 
> I forgot to mention that I tried that too.  But thank you for sending 
> this, because, just to make sure, I tried it again, and now it booted. 
> I think I might have had a typo when adding idle=poll the first time.  
> I think of this as a temporary solution, and I won't be adding that to 
> grub anytime soon.  Manually typing it in at boot time will keep me 
> remembering that it is there.  As long as I make sure that I type it 
> right ;-)
> 
> OK, this means that I don't want to stay in the -RT kernel too long 
> (electric prices are up you know).

you'll get problems on stock SMP kernels too, unless you use idle=poll.  
(or notsc) You can get rid of those warnings in the -rt kernel by 
disabling the PARANOID_GENERIC_TIME .config option. In any case, i think 
that warning should be a once-per-bootup.

	Ingo
