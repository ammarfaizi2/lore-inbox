Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTELLqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTELLqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:46:52 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:53839 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262063AbTELLqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:46:51 -0400
Date: Mon, 12 May 2003 04:59:29 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: MPPE in kernel?
Message-ID: <20030512045929.C29781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What are the chances of getting MPPE (PPP encryption) into the 2.4.21
and/or 2.5.x kernels?

For 2.4.21, sha1 and arcfour code needs to be added, so I don't have
too much hope :-) even though the code is trivial to integrate.

For 2.5.x, just the arcfour code is needed (since sha1 is already there).
I've written a public domain implementation, which I'd be willing to
relicense under GPL (although I don't see the point), but in any case
the algorithm is easy and could be written by anyone.

In addition to the crypto, the mppe compressor module is required.

I'm not so concerned about getting any of that included though; what
I really want is for the changes to ppp_generic.c to be included.
It's not so much fun to have to maintain patches.  The changes required
are generic, don't require crypto, and are generally uneventful.  Getting
the crypto bits and the mppe compressor itself included would just be
a bonus.

/fc
