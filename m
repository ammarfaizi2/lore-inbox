Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271352AbTHMD0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271353AbTHMD0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:26:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62164 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271352AbTHMD0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:26:36 -0400
Message-ID: <3F39AFDF.1020905@pobox.com>
Date: Tue, 12 Aug 2003 23:26:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: davej@redhat.com, greg@kroah.com, willy@debian.org, davem@redhat.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <20030812020226.GA4688@zip.com.au>        <1060654733.684.267.camel@localhost>        <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>        <20030812053826.GA1488@kroah.com>        <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>        <20030812180158.GA1416@kroah.com>        <3F397FFB.9090601@pobox.com>        <20030812171407.09f31455.rddunlap@osdl.org>        <3F3986ED.1050206@pobox.com>        <20030812173742.6e17f7d7.rddunlap@osdl.org>        <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org>
In-Reply-To: <32835.4.4.25.4.1060743746.squirrel@www.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Maybe I read too much into it.  It made me think of Jeff's previous
> remarks about driver config and help being close to but split from
> driver source code.  I saw (read) it as an extension of that:
> a way to package all driver information neatly close together,
> but in separate files.  Someone could modify the config, help, or IDs
> file(s) without mucking with the driver source file(s).


You got it.  I've even queried Roman Zippel about moving some of the 
more simple per-driver fragments in drivers/*/Makefile into 
drivers/*/Kconfig, so that people adding drivers only have to add one 
file, and patch one file.  All of the driver-specific metadata stays in 
one place.

It would be straightforward to put the PCI IDs into Kconfig, even.  We 
already have the parser for it, so writing the tool to generate 
pci_device_id C code initializers already has the backend written.

	Jeff, the radical



