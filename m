Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272220AbTHIAjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272158AbTHIAjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:39:24 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:20114 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S272168AbTHIAiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:38:25 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: David Woodhouse <dwmw2@infradead.org>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E19lHbb-0005mY-00@calista.inka.de>
References: <E19lHbb-0005mY-00@calista.inka.de>
Content-Type: text/plain
Message-Id: <1060389503.11983.39.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Sat, 09 Aug 2003 01:38:23 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: ecki@calista.eckenfels.6bone.ka-ip.net, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This box is IPv4 only -- your email address with only an AAAA record is
probably going to bounce again... :)

On Sat, 2003-08-09 at 01:29, Bernd Eckenfels wrote:
> Is this needing some special hardware support, or is it kind of forcing
> apm/apci power downs? Can you publish that script? I would need that for
> some stress testing of applications and the kernel.

I didn't do it myself -- I just got to fix the bugs which turned up ;)

I think it was done with X10 automated power switching stuff.

> I also wonder, what the best method is to test those hard crashes,
> especially interesting is the case, where disks get power interruption at
> write, to see if the filesystem and block layer recovers from things like
> half written (format needing) blocks.

Journal at application layer to external network-attached storage. Check
on-device fs integrity against your network journal at boot, continue
stress testing from where you left off.

-- 
dwmw2


