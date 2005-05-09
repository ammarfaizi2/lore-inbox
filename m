Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVEIPNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVEIPNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVEIPNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:13:21 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:31117 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261407AbVEIPNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:13:17 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [2.6.12-rc4] network wlan connection goes down
Date: Mon, 9 May 2005 08:12:48 -0700
User-Agent: KMail/1.7.1
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <20050509162454.1c1c09a9@colin.toulouse>
In-Reply-To: <20050509162454.1c1c09a9@colin.toulouse>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505090812.49090.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 May 2005 7:24 am, Colin Leroy wrote:
> Hi,
> 
> I upgraded to 2.6.12-rc4, and noticed something strange after that.
> After a few hours, the network connection goes down. The network
> connectivity is done via a USB wifi stick driven by zd1201.
> 
> After that, nothing gets through, not even a ping. ...
> 
> Would anyone have any hint about what could have changed in the usb
> subsystem (ohci driver) or in the network subsystem, that might cause
> that?

The OHCI code shouldn't have changed either, unless you're
maybe using an old Compaq-brand chipset.  However, if you
enable CONFIG_USB_DEBUG and send the "async" and "registers"
files from the relevant /sys/class/usb_host/usbN directory,
it should be easy to tell whether there's an issue at that
particular level.

- Dave
