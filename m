Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVLMXbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVLMXbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVLMXbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:31:51 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:46776 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030372AbVLMXbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:31:50 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Date: Tue, 13 Dec 2005 15:31:46 -0800
User-Agent: KMail/1.7.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20051211041308.7bb19454.akpm@osdl.org> <200512131422.26224.david-b@pacbell.net> <200512132339.25078.rjw@sisk.pl>
In-Reply-To: <200512132339.25078.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131531.46761.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > 	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {
> > > > 
> > > > What happens if you make that line read
> > > > 
> > > > 	if ((status & STS_PCD) != 0) {
> > > > 
> > > > and ignore the root hub thing?
> > > 
> > > So far, so good.  It works and hasn't triggered the oops yet.  I'll report if there's
> > > anything wrong with it.
> > 
> > I suspect that should be safe to merge for 2.6.15, and it might be
> > worth considering that.  You were using kexec() right?
> 
> No, I was not.  Why would that be important?

Just trying to keep the symptoms straight, that's all.

- Dave
