Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTFTFlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 01:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTFTFlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 01:41:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62733 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262390AbTFTFlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 01:41:50 -0400
Date: Fri, 20 Jun 2003 06:55:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030620065547.B7431@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
References: <20030618234418.GC333@neo.rr.com> <20030619093632.A29602@flint.arm.linux.org.uk> <20030619234249.GA31392@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030619234249.GA31392@neo.rr.com>; from ambx1@neo.rr.com on Thu, Jun 19, 2003 at 11:42:49PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 11:42:49PM +0000, Adam Belay wrote:
> I removed avoid_irq_share because the current pnp code, like the previous, does 
> not allow irq sharing.  Also it corrupts the device rule structure by replacing 
> it with modified values that may not apply after devices are disabled etc.
> Is there a set of conditions I could follow to determine if a serial pnp device 
> is capable of irq sharing, and also with which other devices can a capable 
> device share an irq?  If so, I could have the resource manager handle this type 
> of situation when few irqs are available.

The problem is one of a lack of historical information on why it was
added.  The driver itself allows serial ports to share interrupts between
themselves.  Maybe tytso knows why the "Rockwell 56K ACF II Fax+Data+Voice
Modem" is unable to share IRQs?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

