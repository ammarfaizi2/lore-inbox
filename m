Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUJBPch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUJBPch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 11:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJBPcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 11:32:36 -0400
Received: from wang.choosehosting.com ([212.42.1.230]:39325 "EHLO
	wang.choosehosting.com") by vger.kernel.org with ESMTP
	id S266854AbUJBPcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 11:32:24 -0400
From: Thomas Stewart <thomas@stewarts.org.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: udev remove event not sent untill the device is closed
Date: Sat, 2 Oct 2004 16:31:31 +0100
User-Agent: KMail/1.6.2
References: <200409272252.36016.thomas@stewarts.org.uk> <20041001175312.GB14015@kroah.com>
In-Reply-To: <20041001175312.GB14015@kroah.com>
Cc: linux-kernel@vger.kernel.org
X-PGP-Key: http://www.stewarts.org.uk/public-key.asc
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410021631.31688.thomas@stewarts.org.uk>
X-Scanner: Exiscan on wang.choosehosting.com at 2004-10-02 16:32:17
X-Spam-Score: -1.0
X-Spam-Bars: -
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 18:53, you wrote:
> On Mon, Sep 27, 2004 at 10:52:36PM +0100, Thomas Stewart wrote:
> > However, if I attach the device, open it with say a "cat /dev/ttyUSB0"
> > and then remove the device. No tty events get sent untill I kill the cat.
>
> This is because the tty device remains until the last userspace process
> releases the device.  You might want to trigger your script off of the
> removal of the USB device instead.

I tried that method instead and it works. Now that I think about it more it 
does make more sense.

For anyone else doing something similar this is what I ended up with 
http://www.stewarts.org.uk/stuff/ttyUSB.hotplug not exactly elegant but it 
works.

Thanks
-- 
Tom

PGP Fingerprint [DCCD 7DCB A74A 3E3B 60D5  DF4C FC1D 1ECA 68A7 0C48]
PGP Publickey   [http://www.stewarts.org.uk/public-key.asc]
PGP ID  [0x68A70C48]
