Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbUJ0JIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbUJ0JIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUJ0JIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:08:30 -0400
Received: from colino.net ([213.41.131.56]:21746 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262340AbUJ0JIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:08:24 -0400
Date: Wed, 27 Oct 2004 11:07:56 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.10-rc1 OHCI usb error messages
Message-ID: <20041027110756.3217ed68.colin@colino.net>
In-Reply-To: <200410260905.14869.david-b@pacbell.net>
References: <20041026172843.6ac07c1a.colin@colino.net>
	<200410260905.14869.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs132.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct 2004 at 09h10, David Brownell wrote:

Hi, 

> What's wrong there is emitting voluminous diagnostics for
> something that's not an error ... the root hub is suspended,
> and as with any suspended device, you can't talk to it.

Btw, there's something else wrong, because the root hub shouldn't be 
suspended during boot, should it ? At least, it's not on 2.6.9. Also,
lsusb -v fails with long timeouts due to that on 2.6.10-rc1, not on 2.6.9.

I really think there's something wrong with the drivers/usb/host/ohci-hub.c 
patch I posted in the first message...

-- 
Colin
