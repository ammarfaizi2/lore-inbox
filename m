Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUFNVlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUFNVlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUFNVlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:41:17 -0400
Received: from mail1.kontent.de ([81.88.34.36]:44687 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264492AbUFNVlQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:41:16 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: upcalls from kernel code to user space daemons
Date: Mon, 14 Jun 2004 23:40:58 +0200
User-Agent: KMail/1.6.2
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
References: <1087236468.10367.27.camel@stevef95.austin.ibm.com> <40CDEECF.7060102@nortelnetworks.com>
In-Reply-To: <40CDEECF.7060102@nortelnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406142341.13340.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> > 1) getHostByName:  when the kernel cifs code detects a server crashes
> > and fails reconnecting the socket and the kernel code wants to see if
> > the hostname now has a new ip address.

Is that possible at all? It looks like that might deadlock in the page
out code path.

> > 2) package a kerberos ticket ala RFC2478 (SPNEGO)
> 
> One way to do it (or is this what you meant by captive ioctl?)
> 
> userspace daemon loops on ioctl()
> kernel portion of ioctl call goes to sleep until something to do
> when needed, fill in data and return to userspace
> userspace does stuff, then passes data back down via ioctl()
> ioctl() puts userspace back to sleep and continues on with other work

You could just as well implement an ordinary read()

	Regards
		Oliver
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzhtxbuJ1a+1Sn8oRAvupAJ0T6K8PMeKwWanDTHUmeYtpmsPnKQCeLZbk
cZC0HjRPQSN3Xmkp1tSKFIA=
=tZMS
-----END PGP SIGNATURE-----
