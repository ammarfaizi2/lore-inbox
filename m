Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbVLMWi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbVLMWi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVLMWi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:38:26 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:58596 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030316AbVLMWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:38:24 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Date: Tue, 13 Dec 2005 23:39:24 +0100
User-Agent: KMail/1.9
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20051211041308.7bb19454.akpm@osdl.org> <200512132310.35610.rjw@sisk.pl> <200512131422.26224.david-b@pacbell.net>
In-Reply-To: <200512131422.26224.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512132339.25078.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 13 December 2005 23:22, David Brownell wrote:
> On Tuesday 13 December 2005 2:10 pm, Rafael J. Wysocki wrote:
> > On Tuesday, 13 December 2005 07:52, David Brownell wrote:
> > > > 
> > > > 	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {
> > > 
> > > What happens if you make that line read
> > > 
> > > 	if ((status & STS_PCD) != 0) {
> > > 
> > > and ignore the root hub thing?
> > 
> > So far, so good.  It works and hasn't triggered the oops yet.  I'll report if there's
> > anything wrong with it.
> 
> I suspect that should be safe to merge for 2.6.15, and it might be
> worth considering that.  You were using kexec() right?

No, I was not.  Why would that be important?

Rafael
