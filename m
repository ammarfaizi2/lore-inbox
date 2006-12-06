Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937662AbWLFVYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937662AbWLFVYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937663AbWLFVYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:24:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:58026 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937662AbWLFVYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:24:44 -0500
From: Andi Kleen <ak@suse.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port  support.
Date: Wed, 6 Dec 2006 22:24:33 +0100
User-Agent: KMail/1.9.5
Cc: yinghai.lu@amd.com, stuge-linuxbios@cdy.org, stepan@coresystems.de,
       linuxbios@linuxbios.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, gregkh@suse.de, ebiederm@xmission.com
References: <5986589C150B2F49A46483AC44C7BCA4907290@ssvlexmb2.amd.com> <200612062158.39250.ak@suse.de> <20061206211734.78DCB1E75FF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20061206211734.78DCB1E75FF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612062224.33482.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

\
>   - Host, to which that console connects (through the debug device);
>     runs usb_debug, much like any other usb-serial device

My understanding was that the client could run in user 
space only on top of libusb.

> 
> It's analagous to debugging an embedded box using a serial console
> with a Linux host ... except the target here is a PC, not an ARM
> (or PPC, MIPS, etc) custom board.
> 
> 
> Once the coexistence issues between the debug port and normal EHCI
> driver get worked, there's no reason not to keep using that debug
> port as a system console.  

One reason is the one I covered in my last mail -- locking of the PCI
type 1 ports.

However I suppose it would be ok to switch Eric's code between early
pci access and locked one once the PCI subsystem is up and running.
Just don't forget bust_spinlocks()

-Andi
