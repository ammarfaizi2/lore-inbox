Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVKAEw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVKAEw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVKAEw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:52:56 -0500
Received: from ozlabs.org ([203.10.76.45]:23945 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964958AbVKAEwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:52:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17254.62622.780185.729677@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 15:52:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
In-Reply-To: <200510312017.39915.david-b@pacbell.net>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
	<200510311909.32694.david-b@pacbell.net>
	<1130815836.29054.420.camel@gaston>
	<200510312017.39915.david-b@pacbell.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell writes:

> Maybe you should first pay attention to what I pointed out:  that
> the problem reports I've seen have ONLY been on PPC systems.

Well, there is a problem in the code which is clearly visible just by
inspection: that it is touching a pci device without having called
pci_enable_device on it.  That is well known to cause problems on many
platforms, and it is not guaranteed to work on any platform.

With a clearly visible bug like that in there, it doesn't matter what
platform(s) the problem is reported on.

Paul.
