Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVJaFX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVJaFX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVJaFX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:23:56 -0500
Received: from ozlabs.org ([203.10.76.45]:50612 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751005AbVJaFXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:23:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
Date: Mon, 31 Oct 2005 16:23:33 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Commit "[PATCH] USB: Always do usb-handoff" breaks my
   powerbook
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My G4 powerbook gets a machine check on boot as a result of commit
478a3bab8c87a9ba4a4ba338314e32bb0c378e62.  Putting a return at the
start of quirk_usb_early_handoff fixes it.

The code in quirk_usb_handoff_ohci looks rather bogus in that it
doesn't do pci_enable_device before trying to access the device.

Paul.
