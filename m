Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283259AbRLDSim>; Tue, 4 Dec 2001 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281527AbRLDShY>; Tue, 4 Dec 2001 13:37:24 -0500
Received: from patan.Sun.COM ([192.18.98.43]:33205 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S283259AbRLDSgJ>;
	Tue, 4 Dec 2001 13:36:09 -0500
Message-ID: <3C0D1780.612876EB@sun.com>
Date: Tue, 04 Dec 2001 10:35:44 -0800
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: gibbs@scsiguy.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        eddieath@us.ibm.com
Subject: AIC7xxx and nasty EISA probing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin,

I hope you are still the maintainer of the linux aic7xxx driver, and this
is not just stale info.

I have a user who is reporting nasty interference by the AIC driver into
other devices.  Digging shows the aic7770_linux_probe() routine doing EISA
accesses to io-ports at will.  I've seen the aic7xxx=no_probe comments, but
I wanted to make a small suggestion.

I'd suggest you make no_probe be the default.  I'd much rather see a
CONFIG_AIC7XXX_PROBE option which enabled EISA/VLB probing (which are
probably the minority of devices) and did not interfere with the default
PCI (which I'd guess to be a majority) systems.

If you'd like I can make a patch for this, but the changes should be very
elementary.

As it is, the user has a work around, but I think the other way around
would make a lot more sense and be a fair bit friendlier to the average
user.

Thanks, and let me know if you want me to do the work.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
