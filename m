Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVADKai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVADKai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVADKai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:30:38 -0500
Received: from main.gmane.org ([80.91.229.2]:54230 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261679AbVADKad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:30:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Lucina <mato@kotelna.sk>
Subject: 2.6.10 suspend/resume bustage (was Re: [PATCH] swsusp: properly suspend and resume *all* devices)
Date: Tue, 4 Jan 2005 10:30:11 +0000 (UTC)
Message-ID: <loom.20050104T112419-883@post.gmane.org>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <loom.20050104T093741-631@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.176.172.84 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041128 Firefox/1.0 (Debian package 1.0-4))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Obviously, I don't get the APIC errors, but everything else is the same, random
> devices fail and need to be reloaded (3c59x and uhci-hcd in particular), plus
> the system appears to panic somewhere along the way to resume occasionally

...[panic] and suspend, as I just found out.

I just tried pci=routeirq here, doesn't help.

Another thing I'm seeing sometimes on resume is that the last key pressed on the
keyboard appears to be "stuck". This laptop has a function to ask for a password
on powerup/resume, which presumably is done by the BIOS while in SMM. Since the
last key pressed is ENTER, and I tend to resume into X with an XTerm window
focused, I see the ENTER keypress being repeated for ever, until I hit ENTER
again.

I haven't seen this in any other kernel version, so I'm just mentioning it here
in case it might be relevant.

-mato

