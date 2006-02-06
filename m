Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWBFRbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWBFRbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWBFRbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:31:18 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:47219 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932250AbWBFRbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:31:17 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Date: Mon, 6 Feb 2006 09:31:14 -0800
User-Agent: KMail/1.7.1
Cc: "Carlo E. Prelz" <fluido@fluido.as>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060120123202.GA1138@epio.fluido.as> <200602060824.04945.david-b@pacbell.net> <20060206165014.GC31314@epio.fluido.as>
In-Reply-To: <20060206165014.GC31314@epio.fluido.as>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602060931.15239.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > If it printed that, then how is it possible that it hung _before_ printing
> > that message???
> 
> I already wrote that I had commented out the line that caused the
> hangup:
> 
> //			pci_write_config_byte(pdev, offset + 3, 1);
> 
> After commenting out this line, the machine boots OK and EHCI works
> fine. It does print the BIOS handoff failed message. 

Then if disabling that code which enables the SMI doesn't work,
you have only one real option other than telling your BIOS not
to support USB keyboards/mice/disks:  replace your BIOS.

The reason it prints the BIOS handoff message is because you
completely disabled the handoff, so your BIOS still thinks it
owns that controller.  Commenting out that line is not good.
