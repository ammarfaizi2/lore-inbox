Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVACKOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVACKOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 05:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVACKOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 05:14:32 -0500
Received: from orb.pobox.com ([207.8.226.5]:19920 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261416AbVACKOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 05:14:30 -0500
Date: Mon, 3 Jan 2005 02:14:23 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Barry K. Nathan" <barryn@pobox.com>, lindqvist@netstar.se, edi@gmx.de,
       john@hjsoft.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103084713.GB2099@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 09:47:13AM +0100, Pavel Machek wrote:
> Actually, as you found out in earlier mail, problem is in the driver;
> but it is the interrupt controller driver.
> 
> Right soution is to save APICs state during sysdev_suspend(), and
> resture it during sysdev_resume().

AFAICT proper support is *already* there in sysdev_suspend() and
sysdev_resume().

However, at least on my system, neither of those functions is getting
called! I put BUG()s at the top of both functions, and neither of those
BUGs is being hit in a suspend/resume cycle.

-Barry K. Nathan <barryn@pobox.com>

