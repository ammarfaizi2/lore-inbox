Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVLMWW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVLMWW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVLMWW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:22:28 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:33411 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030285AbVLMWW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:22:27 -0500
From: David Brownell <david-b@pacbell.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-usb-devel] Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Date: Tue, 13 Dec 2005 14:22:25 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20051211041308.7bb19454.akpm@osdl.org> <200512122252.53814.david-b@pacbell.net> <200512132310.35610.rjw@sisk.pl>
In-Reply-To: <200512132310.35610.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131422.26224.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 2:10 pm, Rafael J. Wysocki wrote:
> On Tuesday, 13 December 2005 07:52, David Brownell wrote:
> > > 
> > > 	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {
> > 
> > What happens if you make that line read
> > 
> > 	if ((status & STS_PCD) != 0) {
> > 
> > and ignore the root hub thing?
> 
> So far, so good.  It works and hasn't triggered the oops yet.  I'll report if there's
> anything wrong with it.

I suspect that should be safe to merge for 2.6.15, and it might be
worth considering that.  You were using kexec() right?

- Dave
