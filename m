Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTJ1Jc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTJ1Jc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:32:56 -0500
Received: from gprs197-51.eurotel.cz ([160.218.197.51]:2179 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263900AbTJ1Jcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:32:55 -0500
Date: Tue, 28 Oct 2003 10:32:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Patrick Mochel <mochel@osdl.org>, George Anzinger <george@mvista.com>,
       Pavel Machek <pavel@suse.cz>, John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031028093233.GA1253@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067329994.861.3.camel@teapot.felipe-alfaro.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Userspace behavior on suspend transitions is still a bit fuzzy at best. I 
> > am beginning to look at userspace requirements, so if anyone wants to send 
> > me suggestions, no matter how trivial or wacky, please feel free (on- or 
> > off-list). 
> 
> Many userspace applications are not prepared for suspension, like
> Evolution. When suspending the machine for a long time, all IMAP
> sessions are broken as their counterpart TCP sockets timeout. While
> resuming, Evolution is unable to handle this condition and simply
> informs the network connection has been dropped.
> 
> What about sending the SIGPWR signal to all userspace processes before
> suspending so applications like Evolution can be improved to handle this
> signal, drop their IMAP connections and then, when resuming, reestablish
> them?

Not sure... We do not want applications to know. Certainly we can't
send a signal; SIGPWR already has some meaning and it would be bad to
override it.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
