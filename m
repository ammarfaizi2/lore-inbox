Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUB0Flc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 00:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbUB0Flc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 00:41:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:8378 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261696AbUB0Flb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 00:41:31 -0500
Subject: RE: Why no interrupt priorities?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Mark Gross <mgross@linux.co.intel.com>, arjanv@redhat.com,
       Tim Bird <tim.bird@am.sony.com>, root@chaos.analogic.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
Content-Type: text/plain
Message-Id: <1077859968.22213.163.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 16:32:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is the assumption that hardirq handlers are superfast also the reason
> why Linux calls all handlers on a shared interrupt, even if the first
> handler reports it was for its device?

With level irqs only, it would be possible to return at this
point. But with edge irqs, we could miss it completely if another
device had an irq at the same time

Ben.


