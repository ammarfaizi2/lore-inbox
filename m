Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUBZVqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUBZVqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:46:25 -0500
Received: from gprs147-26.eurotel.cz ([160.218.147.26]:42881 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261155AbUBZVpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:45:41 -0500
Date: Thu, 26 Feb 2004 22:45:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Message-ID: <20040226214531.GA397@elf.ucw.cz>
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <20040225215309.GI1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com> <20040226144155.GQ1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226144155.GQ1052@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 3. putpacket writes the packet and waits for a '+'
> > 4. new gdb sends a protocol initialization packet
> > 5. putpacket reads characters in that packet hoping for an incoming '+' 
> > sending out console message packet on each incoming character
> > 6. gdb receives and rejects each console message packet
> > 
> > > - Remove ok_packet(), excessive, IMHO.
> > 
> > ok_packet is better than littering "OK" all over the place.
> 
> I disagree.  If ok_packet was anything more than
> strcpy(remcom_out_buffer, "OK") you'd be right.

Amit, he's right, having function just for one strcpy only makes code
harder to read. And it does not even save much typing...

	ok_packet(foo);
	strcpy(foo,"OK");

...we are talking 2 or 3 characters here....
								Pavel


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
