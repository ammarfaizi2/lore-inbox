Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUCEAEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 19:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbUCEAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 19:04:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:201 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262002AbUCEAEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 19:04:45 -0500
Subject: Re: problem with cache flush routine for G5?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040304235754.GK26065@smtp.west.cox.net>
References: <40479A50.9090605@nortelnetworks.com>
	 <1078444268.5698.27.camel@gaston>
	 <20040304235754.GK26065@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1078445065.5703.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 11:04:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> ... unless this is a 'G5' that's not in a pmac, it's not my code, and
> the openfirmware bootloaders don't, IIRC, do any cache stuff.

Heh, well, they should. You need to flush the dcache & invalidate the
icache over the kernel image after decompressing it. It's just that
those routines are totally broken as far as I can see, but I don't
think the pmac bootloaders will use them, they probably use a
different implementation that works.

Note that whatever machines are using those routines will probably
have trouble too anyway

Ben.


