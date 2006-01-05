Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWAEDnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWAEDnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWAEDnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:43:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751909AbWAEDnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:43:11 -0500
Date: Wed, 4 Jan 2006 22:42:52 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: ak@suse.de, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Clock going way too fast on 2.6.15 for amd64 processor
Message-ID: <20060105034252.GE2658@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	ak@suse.de, acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20060104233919.GA15724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104233919.GA15724@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 03:39:19PM -0800, Greg KH wrote:
 > Hi,
 > 
 > I tried digging through the mess in
 > 	http://bugzilla.kernel.org/show_bug.cgi?id=3927
 > but got lost in a see of conflicting patches.
 > 
 > I too have a amd64 box that is showing that the clock is running way too
 > fast (feels about double speed, haven't checked for sure.)  I'm running
 > it in 32bit mode for now, and the boot dmesg is below.
 > 
 > [   38.568719] PCI: Found 0000:00:00.0 [1002/5950] 000600 00

Meet the quirky ATI bridge.
http://bugme.osdl.org/show_bug.cgi?id=3927

(It really annoys me btw that you have to go look up
 "who is vendor id 1002" when reading bug reports.
 Losing pci.ids support isn't all it's cracked up to be imo).

 > [   38.594636] PCI: Calling quirk c01e36d0 for 0000:00:00.0
 > [   38.594639] PCI: Calling quirk c0255f20 for 0000:00:00.0
 > [   38.594642] PCI: Calling quirk c01e36d0 for 0000:00:01.0
 > [   38.594645] PCI: Calling quirk c0255f20 for 0000:00:01.0
 > [   38.594647] PCI: Calling quirk c01e36d0 for 0000:00:13.0
 > [   38.594650] PCI: Calling quirk c0255f20 for 0000:00:13.0
 > [   38.622002] PCI: Calling quirk c01e36d0 for 0000:00:13.1
 > [   38.622005] PCI: Calling quirk c0255f20 for 0000:00:13.1
 > [   38.637966] PCI: Calling quirk c01e36d0 for 0000:00:13.2
 > [   38.637969] PCI: Calling quirk c0255f20 for 0000:00:13.2
 > [   38.637982] PCI: Calling quirk c01e36d0 for 0000:00:14.0
 > [   38.637985] PCI: Calling quirk c0255f20 for 0000:00:14.0
 > [   38.637987] PCI: Calling quirk c01e36d0 for 0000:00:14.1
 > [   38.637990] PCI: Calling quirk c0255f20 for 0000:00:14.1
 > [   38.637993] PCI: Calling quirk c01e36d0 for 0000:00:14.3
 > [   38.637995] PCI: Calling quirk c0255f20 for 0000:00:14.3
 > [   38.637998] PCI: Calling quirk c01e36d0 for 0000:00:14.4
 > [   38.638000] PCI: Calling quirk c0255f20 for 0000:00:14.4
 > [   38.638003] PCI: Calling quirk c01e36d0 for 0000:00:14.5
 > [   38.638005] PCI: Calling quirk c0255f20 for 0000:00:14.5
 > [   38.638008] PCI: Calling quirk c01e36d0 for 0000:00:14.6
 > [   38.638010] PCI: Calling quirk c0255f20 for 0000:00:14.6
 > [   38.638013] PCI: Calling quirk c01e36d0 for 0000:00:18.0
 > [   38.638015] PCI: Calling quirk c0255f20 for 0000:00:18.0
 > [   38.638018] PCI: Calling quirk c01e36d0 for 0000:00:18.1
 > [   38.638020] PCI: Calling quirk c0255f20 for 0000:00:18.1
 > [   38.638023] PCI: Calling quirk c01e36d0 for 0000:00:18.2
 > [   38.638025] PCI: Calling quirk c0255f20 for 0000:00:18.2
 > [   38.638028] PCI: Calling quirk c01e36d0 for 0000:00:18.3
 > [   38.638030] PCI: Calling quirk c0255f20 for 0000:00:18.3
 > [   38.638033] PCI: Calling quirk c01e36d0 for 0000:01:05.0
 > [   38.638035] PCI: Calling quirk c0255f20 for 0000:01:05.0
 > [   38.638038] PCI: Calling quirk c01e36d0 for 0000:02:03.0
 > [   38.638040] PCI: Calling quirk c0255f20 for 0000:02:03.0
 > [   38.638043] PCI: Calling quirk c01e36d0 for 0000:02:05.0
 > [   38.638046] PCI: Calling quirk c0255f20 for 0000:02:05.0
 > [   38.638049] PCI: Calling quirk c01e36d0 for 0000:02:05.2
 > [   38.638052] PCI: Calling quirk c0255f20 for 0000:02:05.2
 > [   38.638054] PCI: Calling quirk c01e36d0 for 0000:02:05.3
 > [   38.638057] PCI: Calling quirk c0255f20 for 0000:02:05.3
 > [   38.638059] PCI: Calling quirk c01e36d0 for 0000:02:05.4
 > [   38.638062] PCI: Calling quirk c0255f20 for 0000:02:05.4
 > [   38.638064] PCI: Calling quirk c01e36d0 for 0000:02:09.0
 > [   38.638067] PCI: Calling quirk c0255f20 for 0000:02:09.0

quirky much ? :-)

		Dave

