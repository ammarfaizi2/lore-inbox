Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUKCMHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUKCMHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUKCMHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:07:35 -0500
Received: from [213.146.154.40] ([213.146.154.40]:60362 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261560AbUKCMHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:07:31 -0500
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041103074359.A1542@flint.arm.linux.org.uk>
References: <200409301014.00725.bjorn.helgaas@hp.com>
	 <20041006082919.B18379@flint.arm.linux.org.uk>
	 <1099329348.13633.2192.camel@hades.cambridge.redhat.com>
	 <200411020939.25851.bjorn.helgaas@hp.com>
	 <20041103074359.A1542@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1099483639.13633.2269.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 03 Nov 2004 12:07:19 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-03 at 07:43 +0000, Russell King wrote:
> This call can now be removed - for any serial device, we keep registering
> the console each time a new port is added until it successfully registers.

Er, if we already fixed that, then what was it which still needed to be
fixed? If the console is registered when the port is registered, what
stops us from dropping the static table and letting the i386
setup_arch() code register the port?

You'd still get the console working a lot earlier than it does today --
currently I think we wait for the console_initcalls to start the 8250
console on most platforms, including i386.

-- 
dwmw2

