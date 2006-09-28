Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWI1LH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWI1LH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWI1LH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:07:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:35278 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750733AbWI1LH2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:07:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] driver for mcs7830 (aka DeLOCK) USB ethernet adapter
Date: Thu, 28 Sep 2006 13:07:21 +0200
User-Agent: KMail/1.9.4
Cc: linux-usb-devel@lists.sourceforge.net,
       David Hollis <dhollis@davehollis.com>, support@moschip.com,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Michael Helmling <supermihi@web.de>
References: <200609170102.50856.arnd@arndb.de> <200609271828.58205.david-b@pacbell.net>
In-Reply-To: <200609271828.58205.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609281307.22923.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 03:28, David Brownell wrote:
> ... yes, I'd assume it's a hardware issue too.  Try different
> cables; if you have a fast 'scope, you might see what kind of
> eye diagram you get.

Unfortunately, I don't have anything I could use to test this.

> Do you know how the remote wakeup mechanism works for this chip?
> It'd be interesting to see "usbnet" be taught how to autosuspend
> chips which will wake up the USB host when they get the right
> kind of packet ... for example, passing the multicast/broadcast
> filter, or addressed directly to that adapter.
> 
> Such an autosuspend mechanism would let the host controller stop
> polling a mostly-idle network link, getting rid of one source of
> periodic DMA transfers and thus allowing deeper sleep states for
> many x86 family CPUs.  And also, I'd expect, giving fewer
> opportunities for those broken RX packets.  :)

No, don't know. I did not find anything about this in the public
spec.

	Arnd <><
