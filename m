Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUJEU1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUJEU1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJEU1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:27:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59151 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263962AbUJEU1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:27:17 -0400
Date: Tue, 5 Oct 2004 21:27:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041005212712.I6910@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041005185214.GA3691@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Tue, Oct 05, 2004 at 08:52:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 08:52:14PM +0200, Jörn Engel wrote:
> Looks pretty trivial, but opinions on this subject may vary.
> Comments?

There's a related problem.  /sbin/hotplug.  I keep seeing odd failures
from /sbin/hotplug scripts which go away when I ensure that fd0,1,2 are
directed at something real.

It's rather annoying because it currently means that, when my PCMCIA net
interface on the firewall comes up, the IPv4 configuration works fine
but IPv6 configuration falls dead on its nose without any explaination
why.

And, like I say, redirecting fd0,1,2 fixes it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
