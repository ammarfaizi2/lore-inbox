Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbTLIVPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbTLIVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:15:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47121 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266145AbTLIVOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:14:45 -0500
Date: Tue, 9 Dec 2003 21:14:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Reppert <repp0017@tc.umn.edu>
Cc: Guennadi Liakhovetski <gl@dsa-ac.de>, linux-kernel@vger.kernel.org,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [OOPS] 2.6.0-test11 sysfs
Message-ID: <20031209211440.A16651@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Reppert <repp0017@tc.umn.edu>,
	Guennadi Liakhovetski <gl@dsa-ac.de>, linux-kernel@vger.kernel.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Patrick Mochel <mochel@osdl.org>
References: <Pine.LNX.4.33.0312091826090.1130-100000@pcgl.dsa-ac.de> <1070992648.27231.7.camel@minerva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1070992648.27231.7.camel@minerva>; from repp0017@tc.umn.edu on Tue, Dec 09, 2003 at 11:57:28AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 11:57:28AM -0600, Matthew Reppert wrote:
> Try this patch. (Patrick, is this the sane thing to do? And is it worth
> it? If so, I can do similar things to the other sysfs_create_* functions
> if you would like.)

Actually the "right" thing to do is to drop the file creation stuff from
i82365; due to an interaction between sysfs and pcmcia, we can't register
class device files in the initialisation path.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
