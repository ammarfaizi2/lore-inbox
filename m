Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTIHWR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbTIHWRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:17:55 -0400
Received: from gprs145-40.eurotel.cz ([160.218.145.40]:30853 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263698AbTIHWRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:17:51 -0400
Date: Tue, 9 Sep 2003 00:17:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: Paul Clements <Paul.Clements@SteelEye.com>, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
Message-ID: <20030908221739.GF429@elf.ucw.cz>
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com> <3F5CFCF2.7080308@upb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5CFCF2.7080308@upb.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Well, i guess the cache uses a value of 256 sectors to do read-ahead and
> >>such.
> >
> >Well it sounds like the real problem here is the vm_max_readahead
> >setting then. Try this:
> 
> I will try it, although i think that i'm using the deafult values.
> 
> Anyway: the NBD module should set the max_sectors to a certain value - i 
> chose 256 sectors. Perhaps Pavel or Paul may decide to use a higher ot 
> smaller value. A limit should be part of the protocol or handshaked when 
> connecting to the server (what is not possible without changing the 
> protocol)

I do not see a reason it should be handshaked. IMNSHO we should simply
say that no request should be bigger than 1MB in protocol, make sure
that kernel does <=128KB requests, and make sure nbd-servers can
handle 1MB, and be done with that.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
