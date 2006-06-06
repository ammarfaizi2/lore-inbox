Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751197AbWFFAcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWFFAcb (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 20:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWFFAcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 20:32:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:30689 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751187AbWFFAc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 20:32:28 -0400
Subject: Re: [PATCH 8/9] PCI PM: clear IO and MEM when disabling a device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1149497176.7831.162.camel@localhost.localdomain>
References: <1149497176.7831.162.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 10:32:16 +1000
Message-Id: <1149553936.559.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 04:46 -0400, Adam Belay wrote:
> This patch modifies pci_disable_device() to clear IO and MEM from the
> COMMAND PCI config register.  This is required before entering D3,  but
> also probably a good general practice for system suspend.

And will break a great deal of platforms. Don't do it :) The problem is,
I think, mostly related to firmware issues.

Ben.


