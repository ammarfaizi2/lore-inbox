Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265660AbUF2Iqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUF2Iqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 04:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUF2Iqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 04:46:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64773 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265590AbUF2Iqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 04:46:32 -0400
Date: Tue, 29 Jun 2004 09:46:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
       greg@kroah.com
Subject: Re: [RFC][PATCH] driver model and sysfs support for PCMCIA (1/3)
Message-ID: <20040629094624.A19610@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org, linux@dominikbrodowski.de,
	akpm@osdl.org, rml@ximian.com, greg@kroah.com
References: <20040628200224.GE5175@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040628200224.GE5175@neo.rr.com>; from ambx1@neo.rr.com on Mon, Jun 28, 2004 at 08:02:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 08:02:24PM +0000, Adam Belay wrote:
> This patch updates the pcmcia subsystem to utilize the driver model and sysfs.
> It cooperates peacefully with pcmcia-cs and does not break any drivers or
> require any API changes.  It has been tested and is stable on my boxes.

Thank you, I'll add this to my collection of PCMCIA device model
patches.  I have quite a selection. 8)

I still have rather a number of patches for the pcmcia resource and
socket driver side of things, and I'm hesitant to put anything other
than bug fixes in before these are all in.  This is something which
will only proceed slowly - hopefully it should be complete by 2.6.9.
This is especially slow because the only kernels which appear to be
well tested for PCMCIA are Linus' main releases and I don't want to
push too many changes in at one time.

Also, there remain races in the PCMCIA network drivers in their unload
code - they free everything and _then_ unregister from the network
layer. This should be fixed before we even think of adding device
model support... I thought I'd already sent this patch, but it seems
it never made it into the kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
