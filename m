Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTBXNXz>; Mon, 24 Feb 2003 08:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTBXNXz>; Mon, 24 Feb 2003 08:23:55 -0500
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:57237 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S267039AbTBXNXy> convert rfc822-to-8bit; Mon, 24 Feb 2003 08:23:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Duncan Sands <baldrick@wanadoo.fr>, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB speedtouch: better proc info
Date: Mon, 24 Feb 2003 11:43:20 +0100
User-Agent: KMail/1.4.3
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200302241058.52073.baldrick@wanadoo.fr>
In-Reply-To: <200302241058.52073.baldrick@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302241143.20632.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 24. Februar 2003 10:58 schrieb Duncan Sands:
> Output the correct device name, show the state of the device (for
> debugging) and of the ADSL line (anyone want to write a graphical utility
> to show this, like under windows?).  We no longer consult the usb_device
> struct in udsl_atm_proc_read, so don't take a reference to it.  Against
> Greg's current 2.5 USB tree.

First of all, let me say that you're doing wonders with this driver.
But this particular patch I don't like. It improves stuff that should
be removed. More specifically:

1. Does anything prevent you from using the medium detection
hooks the network layer provides?
2. What need is there to export manufacturer id and mac address
again?
3. Doesn't the rest belong into sysfs rather than procfs?

	Regards
		Oliver

