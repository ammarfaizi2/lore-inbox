Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268387AbUHQShS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268387AbUHQShS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268389AbUHQShS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:37:18 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:10287 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268387AbUHQShP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:37:15 -0400
Message-ID: <fb20c214040817113715e6202b@mail.gmail.com>
Date: Tue, 17 Aug 2004 13:37:11 -0500
From: Brian Jackson <notiggy@gmail.com>
Reply-To: Brian Jackson <notiggy@gmail.com>
To: Nigel Kukard <nkukard@lbsd.net>
Subject: Re: external drive size differences
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040815093759.GK31901@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040815093759.GK31901@lbsd.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 11:37:59 +0200, Nigel Kukard <nkukard@lbsd.net> wrote:
> Something very very interesting... below is an external drive enclosure
> supporting both USB2 and Firwire, fitted with a 200Gb IDE Hdd.
> 
> When plugged into the firewire bus, i get 137Gb size, when plugged into
> the usb bus, i get 200Gb size.
> 
> Could this be a bug in the kernel? or external hardware?

More than likely hardware. Most of the oxford chips that are so often
used in firewire enclosures, don't support >137G drives. It probably
uses a different chip for the usb side of things.

--Iggy

> 
> <snip>
> ieee1394: sbp2: Logged into SBP-2 device
> ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
>   Vendor: WDC WD20  Model: 00JB-00FUA0       Rev:
>   Type:   Direct-Access                      ANSI SCSI revision: 06
> SCSI device sdb: 268435455 512-byte hdwr sectors (137439 MB)
> sdb: asking for cache data failed
> sdb: assuming drive cache: write through
>  sdb: sdb1
> </snip>
> 
> <snip>
> scsi7 : SCSI emulation for USB Mass Storage devices
>   Vendor: USB 2.0   Model: Storage Device    Rev: 0100
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
> sdb: assuming drive cache: write through
>  sdb: sdb1
> </snip>
> 
> Regards
> Nigel Kukard
