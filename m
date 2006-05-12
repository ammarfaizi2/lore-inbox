Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWELNYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWELNYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWELNYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:24:43 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:53744 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751287AbWELNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:24:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Yju52iahxu8c9XkJv270ZjmbD+aM4F/oyd2x1YqvuD6SipWAd45m/wxG3kwzWoDFV0kbT7rQcLtYOmkCkMzakPZ98UWYMwkrQXWbCncT8qTvtR2cb1jmyir/cwd8RIwrUl+RjZKzH+hjkgo8jLMwuQ7+HlAf6S//e9WgktIQ4Tg=
Date: Fri, 12 May 2006 22:24:37 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against stable kernel
Message-ID: <20060512132437.GB4219@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

Lately libata has been going through a lot of changes and even more
are around the corner.  I've been working on error handling and
advanced SATA features for quite sometime now, and, finally, patches
have been finalized and submitted for review a few days ago.

2.6.18 is the target for mainline merge.  As there is quite some time
between now and 2.6.18, I have made patches to update the current
stable kernel to support the new features so that they can receive
wider testing and interested people don't have to wait too long.  I
intend to maintain these patches through 2.6.16 and 17 until the
mainline merge happens.

Added new features are

* New error handling
* IRQ driven PIO (from Albert Lee)
* SATA NCQ support
* Hotplug support
* Port Multiplier support

The following drivers support new features.

ata_piix:	new EH, irq-pio, warmplug (hardware restriction)
sata_sil:	new EH, irq-pio, hotplug
ahci:		new EH, irq-pio, NCQ, hotplug
sata_sil24:	new EH, irq-pio, NCQ, hotplug, Port Multiplier

More info can be found at the following URL.

 http://home-tj.org/wiki/index.php/Libata-tj-stable

Patches against v2.6.16.16 is avaialbe at the following URL.

 http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.16.16-20060512.tar.bz2

Please read README carefully before testing the patches.  Keep in mind
that these are still quite experimental and not ready for production
use.

Thanks.

-- 
tejun
