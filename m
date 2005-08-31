Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVHaNOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVHaNOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVHaNOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:14:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39596 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964789AbVHaNOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:14:30 -0400
Subject: Re: [FINAL WARNING] Removal of deprecated serial functions -
	please update your drivers NOW
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
In-Reply-To: <20050831135258.D1118@flint.arm.linux.org.uk>
References: <20050831103352.A26480@flint.arm.linux.org.uk>
	 <1125493224.3355.1.camel@localhost.localdomain>
	 <20050831135258.D1118@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Aug 2005 14:38:10 +0100
Message-Id: <1125495490.3355.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-31 at 13:52 +0100, Russell King wrote:
> The key thing is that port.dev should be set appropriately and the
> relevant calls to serial8250_suspend_port/serial8250_resume_port
> be made (or port.dev should be NULL if no power management is
> expected - in which case it may be managed as a generic platform
> port.)

Thanks. Thats all I needed to know to whack that into shape once I've
put a legacy 32bit build environment back together for this and for
something akpm wants me to fix in another diff.

Power management is umm special. The port will die on suspend/resume via
Linux (via APM seems to be ok) and need a userspace firmware reload to
come back.

