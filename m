Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUAGA2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 19:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUAGA2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 19:28:37 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:44713 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S265494AbUAGA2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 19:28:36 -0500
Subject: Re: Kconfig entryf or Pegasus USB Ethernet device
From: David T Hollis <dhollis@davehollis.com>
To: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401070051.40350.vergata@stud.fbi.fh-darmstadt.de>
References: <200401070051.40350.vergata@stud.fbi.fh-darmstadt.de>
Content-Type: text/plain
Message-Id: <1073435308.5675.1.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 06 Jan 2004 19:28:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-06 at 18:51, Sergio Vergata wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi all,
> 
> Just a small hint for USB Ethernet device.
> 
> I only have 1000Mbit card and for testing purpose an External USB 
> Ethernetdongle, so why should I build Ethernet 10 /100 Mbit when i only need 
> an USB Network adapter.
> 
> So if I'm right this should work too just like the other devices too.
> 
The NET_ETHERNET config option is just for Kconfig and does not have an
impact on the resulting kernel.  It does make more semantic sense to
have Pegasus, usbnet, etc use the NET_ETHERNET option as they are
Ethernet devices, not some type of generic network device. 
Additionally, depending on how you configure usbnet, it will require MII
which also depends on NET_ETHERNET, so you would wind up that way
anyway.

-- 
David T Hollis <dhollis@davehollis.com>

