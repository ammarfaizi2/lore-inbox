Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbQJ1QLE>; Sat, 28 Oct 2000 12:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbQJ1QK6>; Sat, 28 Oct 2000 12:10:58 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:30400 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131139AbQJ1QKo>; Sat, 28 Oct 2000 12:10:44 -0400
Message-ID: <39FAFA68.A8250BA@uow.edu.au>
Date: Sun, 29 Oct 2000 03:10:16 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au> <20001028141518.A2272@parcelfarce.linux.theplanet.co.uk> <39FAD698.2FF9C8C8@didntduck.org> <20001028145312.B2272@parcelfarce.linux.theplanet.co.uk> <39FADAC9.DC1255D1@didntduck.org> <20001028160537.C2272@parcelfarce.linux.theplanet.co.uk> <39FAF5BE.C79801A2@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> With or without your patch, the network ioctls are unsafe, since they
> don't currently do refcounting at all.  Adding it in the layer above the
> driver is the easier and cleaner solution.

As long as the drivers use unregister_netdevice() then that's
fairly easy to fix within the netdevice layer.  Just do a 
dev_hold()/dev_put() within dev_ifsioc().
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
