Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWFSIoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWFSIoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWFSIoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:44:13 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:64913 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751229AbWFSIoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:44:13 -0400
From: Duncan Sands <baldrick@free.fr>
To: juampe <juampe@iquis.com>
Subject: Re: [PATCH 06/13] USBATM: shutdown open connections when disconnected
Date: Mon, 19 Jun 2006 10:44:10 +0200
User-Agent: KMail/1.9.1
Cc: kernel <linux-kernel@vger.kernel.org>,
       linux-atm-general@lists.sourceforge.net
References: <OF39174CF7.B508FCBD-ONC125718F.00407FFC-C125718F.00413F4F@telefonica.es> <44965CC3.1060203@iquis.com>
In-Reply-To: <44965CC3.1060203@iquis.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191044.10820.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juampe,

On Monday 19 June 2006 10:13, juampe wrote:
> > This patch causes vcc_release_async to be applied to any *open
> >** v*cc's when the modem is *disconnected*. 
> 
> 
> > Unfortunately this patch may create problems
> > for those rare users like me who use routed IP or some other
> > non-ppp connection method that goes via the ATM ARP daemon: the
> > daemon is buggy, and with this patch will crash when the modem
> > is *disconnected*.  Users with a buggy atmarpd can simply restart
> > it after disconnecting the modem.
> 
> First i must thanks all effort in usbatm development.
> IMHO New fatures to a driver that works well and can block the use, 
> especially if it can disable internet access and the problem is know,
> MUST be disabled by default or provide a mechanism to disable it.
>
> I'm a rare user with routed IP and this patch blocks the normal use of internet
> I dont understand how this patch can be accepted for a stable release without 
> any kind of disable mechanism.
> 
> Yeah, i know that atmarp is buggy, but before speedtouch driver and atm works well during months.

why don't you just restart atmarpd?  After all, if you are unplugging and
replugging your modem, surely you can restart the daemon at the same time?

I didn't feel it was necessary to have an override mechanism for this new,
correct behavior (which makes things better for people using pppd, i.e. most
people) since a simple workaround exists.

What is very bad however is that atmarpd is still not fixed.  I had a look,
got stuck, and asked for help on the linux-atm list, but no-one replied.
There has been no progress since then.  I will have another look - maybe
you can too?

Best wishes,

Duncan.
