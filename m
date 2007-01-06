Return-Path: <linux-kernel-owner+w=401wt.eu-S932252AbXAFW2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbXAFW2V (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 17:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbXAFW2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 17:28:21 -0500
Received: from main.gmane.org ([80.91.229.2]:58063 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbXAFW2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 17:28:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: JMicron JMB363 SATA hard disk appears twice (sda + hdg)
Date: Sat, 6 Jan 2007 23:27:54 +0100
Message-ID: <1ismaevxws90w$.8djqjl1c5jzy$.dlg@40tude.net>
References: <31vxryq446ny.b23nrmopmm4.dlg@40tude.net> <20070106182454.GA12426@dreamland.darkstar.lan> <20070106193541.1f211289@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-54-235.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007 19:35:41 +0000, Alan wrote:

> The kernel drivers work on the basis that if you are using drivers/ide
> then the IDE driver will grab all the ports, if you are using libata then
> the PCI boot quirks will switch to split AHCI and PATA mode and the
> libata drivers will take both. 
> 
> If you build both IDE and libata support for the same hardware into your
> kernel it should generally end up with only one driver claiming the
> hardware but the AHCI case doesn't handle this in 2.6.18.

[and in another post:]

> You have both the drivers for the Jmicron via drivers/ide and via
> drivers/ata (libata) loaded. In that specific combination the two drivers
> don't use the same resources so don't spot the other one is busy.

Thanks for the explanation. I had suspected such an interaction,
especially since browsing the LKML it seems that this doubling of the
interfaces with the JMicron controllers is an intentional change:
<URL:http://lkml.org/lkml/2006/7/12/133>.

So the only problem is how to tell the kernel to not use ide on the
SATA channels, and this is what I had tried to do with ide2=noprobe
ide3=noprobe. However, this doesn't seem to happen. Am I
misinterpreting the meaning of the idex=noprobe parameter?

BTW, is there a preference for libata or the jmicron ide driver?
Assuming I finally manage to only make it appear once, which one
should I go for?

-- 
Giuseppe "Oblomov" Bilotta

"I weep for our generation" -- Charlie Brown

