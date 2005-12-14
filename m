Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbVLNQHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVLNQHE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVLNQHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:07:04 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:10001 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S932624AbVLNQHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:07:03 -0500
From: Meelis Roos <mroos@linux.ee>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
In-Reply-To: <1134573803.25663.35.camel@localhost.localdomain>
User-Agent: tin/1.7.10-20050815 ("Grimsay") (UNIX) (Linux/2.6.15-rc5-g90ac8f77 (i686))
Message-Id: <20051214160700.7348A14BEA@rhn.tartu-labor>
Date: Wed, 14 Dec 2005 18:07:00 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AC> The receive_chars function is designed to handle the case where the port
AC> is jammed full on by aborting after 256 characters in one IRQ.
AC> Unfortunately the author of this code forgot that some systems are level
AC> triggered. On these systems the IRQ simply gets invoked again and the
AC> count loop just makes the problem take longer to clear.

Could this be connected wiht the massive amount of these messages when I
use minicom on a PC to see another computers serial console?

serial8250: too much work for irq4

I've seen this on different PC-s, PIIX3+K6 and ICH2+Celeron are the
last ones that I certainly remember behaving like this.

-- 
Meelis Roos
