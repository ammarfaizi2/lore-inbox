Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUCULub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 06:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUCULub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 06:50:31 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64481
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263639AbUCULu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 06:50:27 -0500
Date: Sun, 21 Mar 2004 12:51:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa3
Message-ID: <20040321115118.GB10787@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random> <2910700000.1079849836@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2910700000.1079849836@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 10:17:16PM -0800, Martin J. Bligh wrote:
> > Fixed the sigbus in nopage and improved the page_t layout per Hugh's
> > suggestion. BUG() with discontigmem disabled if somebody returns non-ram
> > via do_no_page, that cannot work right on numa anyways.
> 
> OK, well it doesn't oops any more. But sshd still dies as soon as it starts,
> so accessing the box is tricky ;-) And now I have no obvious diagnostics
> either ...

no surprise, you correctly get a sigbus now that kills sshd. Can you try
with mainline 2.6.5-rc1 to see if it works there?
