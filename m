Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTGAPYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 11:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTGAPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 11:24:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51631 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262439AbTGAPYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 11:24:09 -0400
Date: Tue, 1 Jul 2003 10:38:27 -0500
From: linas@austin.ibm.com
To: linux-kernel@vger.kernel.org
Subject: panic and timer interrupts?
Message-ID: <20030701103827.A24070@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've got a machine here that just did one of the stranger kernel
things I've ever seen. Due to some bug, it panic'ed. But then, during
the panic, it took a timer interrupt, and then handled some network
interrupts, handled some network data, and seems to maybe even have
scheduled some user-land processes before getting hoplessly tangled up.

So, my naive kernel questions as follows: I would have thought that
interrupts would be disabled during a panic, but I can't find any code
that does this. Why is this? Is this a bug? Is this intentional?

It got me to thinking about a hang mode I've seen not infrequently
on PC's: Machine is hung, unresponsive to keyboard, telnet, etc. but
does reply to pings. I've never bothered to debug those, but now I'm
wondering if that's a related manifestation.

--linas

