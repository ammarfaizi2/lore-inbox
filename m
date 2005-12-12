Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVLLWAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVLLWAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVLLWAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:00:16 -0500
Received: from main.gmane.org ([80.91.229.2]:39617 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932081AbVLLWAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:00:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Date: Mon, 12 Dec 2005 13:56:56 -0800
Message-ID: <87acf62d3r.fsf@benpfaff.org>
References: <20051211041308.7bb19454.akpm@osdl.org>
	<200512122155.43632.rjw@sisk.pl>
	<20051212130957.146fbcc3.akpm@osdl.org>
	<200512122239.20264.rjw@sisk.pl>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:IQpANnkkKn1UJJrLdpgOKqPutbs=
Cc: linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

>Namely, it followed from the oops that the problem
> occured at the address {:ehci_hcd:ehci_irq+224}, which is at the
> offset 224 wrt ehci_irq, so I did:
>
> gdb drivers/usb/host/ehci-hcd.o
>
> In gdb I did:
>
> info line ehci_irq
>
> and it told me the address the line started at, so I added 224 to it and
> got the line 620.

You can do the arithmetic yourself like that, but it's easier to
just type
        info line *ehci_irq+224
and let gdb do it for you.
-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org

