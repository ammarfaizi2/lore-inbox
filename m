Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbULVSuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbULVSuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbULVSuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:50:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4109 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262014AbULVSt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:49:58 -0500
Date: Wed, 22 Dec 2004 18:49:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
Message-ID: <20041222184954.A10968@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Gefre <pfg@sgi.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	matthew@wil.cx
References: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com> <20041222134423.GA11750@infradead.org> <20041222140348.A1130@flint.arm.linux.org.uk> <41C990CA.20208@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41C990CA.20208@sgi.com>; from pfg@sgi.com on Wed, Dec 22, 2004 at 09:20:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 09:20:42AM -0600, Patrick Gefre wrote:
> Russell King wrote:
> > You want to register with the serial core before you register with PCI.
> > Then add each port when you find it via the PCI driver ->probe method.
> > 
> > Removal is precisely the reverse order - remove each port in ->remove
> > method first, then unregister from serial core.
> 
> How do I know how many ports I have when I register with serial core ?
> I use the info I got when i probed to fill in .nr

You need to decide on a maximum number of ports and always use that.
You only need to add the ports that you actually have in reality
though.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
