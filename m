Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937623AbWLFViW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937623AbWLFViW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937660AbWLFViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:38:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51859 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937623AbWLFViV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:38:21 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: David Brownell <david-b@pacbell.net>, yinghai.lu@amd.com,
       stuge-linuxbios@cdy.org, stepan@coresystems.de, linuxbios@linuxbios.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port  support.
References: <5986589C150B2F49A46483AC44C7BCA4907290@ssvlexmb2.amd.com>
	<200612062158.39250.ak@suse.de>
	<20061206211734.78DCB1E75FF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200612062224.33482.ak@suse.de>
Date: Wed, 06 Dec 2006 14:37:29 -0700
In-Reply-To: <200612062224.33482.ak@suse.de> (Andi Kleen's message of "Wed, 6
	Dec 2006 22:24:33 +0100")
Message-ID: <m1y7pk4sfa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> \
>>   - Host, to which that console connects (through the debug device);
>>     runs usb_debug, much like any other usb-serial device
>
> My understanding was that the client could run in user 
> space only on top of libusb.

Looks like a normal serial port with greg's patch.
I still need to try it though.

> One reason is the one I covered in my last mail -- locking of the PCI
> type 1 ports.
>
> However I suppose it would be ok to switch Eric's code between early
> pci access and locked one once the PCI subsystem is up and running.
> Just don't forget bust_spinlocks()

No pci access on that path.

Eric
