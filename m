Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWFUUWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWFUUWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWFUUWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:22:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3512 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751420AbWFUUWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:22:42 -0400
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
	underruns, USB HDD hard resets)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: andi@lisas.de, Bodo Eggert <7eggert@gmx.de>, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
       linux-kernel@vger.kernel.org, hal@lists.freedesktop.org
In-Reply-To: <Pine.LNX.4.44L0.0606211501290.8272-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0606211501290.8272-100000@iolanthe.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 21:37:35 +0100
Message-Id: <1150922255.15275.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 15:02 -0400, ysgrifennodd Alan Stern:
> It's not a USB issue; it's a matter of lack of coordination between the sg 
> and sr drivers.  Each is unaware of the actions of the other, even when 
> they are speaking to the same device.

Thats a relevant issue but sg is irrelevant for cd burning except with
various ancient software setups. Probably sg/sr should share the O_EXCL
locking but its not part of the cd burning stuff for modern setups.

Alan

