Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbUDZHFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUDZHFo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 03:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUDZHFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 03:05:44 -0400
Received: from zaphod.lin-gen.com ([195.64.80.164]:62646 "EHLO zaphod.dth.net")
	by vger.kernel.org with ESMTP id S262956AbUDZHFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 03:05:43 -0400
Date: Mon, 26 Apr 2004 09:05:42 +0200
From: Danny ter Haar <dth@dth.net>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No luck getting 2.6.x kernel to work with ACPI on compaq laptop
Message-ID: <20040426070542.GA20973@dth.net>
References: <c65252$9cs$1@news.cistron.nl> <20040426062512.GA11567@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426062512.GA11567@bitwizard.nl>
X-Message-Flag: WARNING!! You are using MS (f)outlook: Please consider upgrading to software with less bugs.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rogier Wolff (R.E.Wolff@BitWizard.nl):
> > After this the machine is dead in the water.
> > No magic sysrq or anything.
> 
> It sounds as if some driver is using IRQ10, and that another device
> is also on that IRQ. This will create an interrupt storm the moment
> you switch the triggering from edge to level....
> So: Which devices use IRQ10 when the computer works?

Len Brown from Intel sent me :

"try booting with "nolapic" (or disable LOCAL_APIC in the kernel build)"

That indeed solved my problem, i can now use poweroff etc.
I will add a bugreport to http://bugzilla.kernel.org/show_bug.cgi?id=1682
l8er this week ;-)

Danny

-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -
