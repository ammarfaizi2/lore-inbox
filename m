Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbTGHPam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267461AbTGHPam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:30:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37292
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267460AbTGHPak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:30:40 -0400
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : Cisco mpi350 _way_
	sub-optimal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerald Britton <gbritton@alum.mit.edu>
Cc: emperor@EmperorLinux.com, LKML <linux-kernel@vger.kernel.org>,
       EmperorLinux Research <research@EmperorLinux.com>,
       "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <20030708112016.A10882@light-brigade.mit.edu>
References: <1054658974.2382.4279.camel@tori> <20030610233519.GA2054@think>
	 <200307071412.00625.durey@EmperorLinux.com>
	 <1057672948.4358.20.camel@dhcp22.swansea.linux.org.uk>
	 <20030708112016.A10882@light-brigade.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057678950.4358.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 16:42:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 16:20, Gerald Britton wrote:
> Some of them have issues with PCI resource allocation though.  Their BIOSes
> don't allocate resources to Cardbus bridges so insertted devices can't get
> resources and last i checked, we didn't handle this fixup.

Thats actually a Linux bug.

> On the notebooks I worked with it required relocating the AGP bridge and several other devices
> to make all the resources work out (quick hack is to just shove new resources
> into the config registers prior to the kernel's initial pci scan).

Interesting. I wonder why our fixup would have failed - its not something I've
seen but we should fixup cardbus resource blocks (2.4 isnt smart enough to
handle multidevice cardbus but Rmk has 2.5 code that is), but for the normal
case it ought to have worked.

