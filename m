Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTFJSYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTFJSYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:24:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6917 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262066AbTFJSYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:24:16 -0400
Date: Tue, 10 Jun 2003 19:37:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE IRQ probe brokenness.
Message-ID: <20030610193750.A18912@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1055233984.29633.56.camel@passion.cambridge.redhat.com> <1055263361.32661.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1055263361.32661.10.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 10, 2003 at 05:42:41PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 05:42:41PM +0100, Alan Cox wrote:
> Basically we need a "NOT_AN_IRQ" value defined either globally or per
> port

All it needs is for someone to add the definition for NO_IRQ to all
architecture header files.  ARM has an established use of NO_IRQ
already with currently 34 uses:

/*
 * Use this value to indicate lack of interrupt
 * capability
 */
#ifndef NO_IRQ
#define NO_IRQ  ((unsigned int)(-1))
#endif

I'd prefer not to do another mindless time wasteful change just because
someone decides to use a different name.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

