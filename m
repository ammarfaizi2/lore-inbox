Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135276AbRDLTcd>; Thu, 12 Apr 2001 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135277AbRDLTcX>; Thu, 12 Apr 2001 15:32:23 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:57653 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S135271AbRDLTaI>;
	Thu, 12 Apr 2001 15:30:08 -0400
Message-ID: <3AD601B4.7E0B14E4@sgi.com>
Date: Thu, 12 Apr 2001 14:27:48 -0500
From: Steve Modica <modica@sgi.com>
Reply-To: modica@sgi.com
Organization: sgi
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, modica@sgi.com
Subject: Proposal for a new PCI function call
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We found recently that the acenic driver for the 3com gigabit ethernet card does
not enable 64 bit DMAs.  (this is done by setting the appropriate mask in
pci_dev->dma_mask).

Jes suggested that the appropriate way to fix this would be to create a function
like pci_enable_dma64 and then have the driver call that, rather than directly
setting this value (a small handful of drivers do this now).

I think the function idea would let us do some sanity checking to make sure
drivers weren't setting this to 64bit on non-64 bit busses and stuff.

Anyhow, so long as no one has any heartburn with this, we'll try to put
something together and submit it.  I'm not subscribed to the list *yet* (need to
get procmail setup), so please leave me in the CC line.

Thanks!
Steve

-- 
Steve Modica
Manager - Networking Drivers Group
"Give a man a fish, and he will eat for a day, hit him with a fish and
he leaves you alone" - me
