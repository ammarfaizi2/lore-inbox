Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319823AbSIMXO4>; Fri, 13 Sep 2002 19:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319824AbSIMXO4>; Fri, 13 Sep 2002 19:14:56 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:13493 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S319823AbSIMXOz>; Fri, 13 Sep 2002 19:14:55 -0400
Date: Fri, 13 Sep 2002 16:20:05 -0700
From: David Brownell <david-b@pacbell.net>
Subject: 2.4.20-pre7 USB 2.0 "ehci-hcd" patches
To: linux-kernel@vger.kernel.org
Message-id: <3D8272A5.5030405@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I'd send the note here as well as to the Linux-USB list.
Either because I thought the exposure to more folk that may have
shiny new hardware could be useful, or because I'm a glutton for
punishment ... I'm not sure yet.

The two patches are archived, such as

  http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103195770819572&w=2
  http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103195884620392&w=2

I won't see LKML followups unless you cc me, but I'll see posts
on the USB developer's list.

- Dave


-------- Original Message --------
Subject: [linux-usb-devel] [PATCH 2.4.20-pre7 0 of 2] EHCI updates
Date: Fri, 13 Sep 2002 15:51:11 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net

I'm sending a couple of EHCI related patches out for folk who'd
like to try this on top of 2.4.20-pre7.

I'd like to see if anyone has any feedback about it before taking
the next steps to get it into 2.4.20 ... there are improvements,
but likely some problems could still stand to get fixed.

If you're using EHCI hardware, please try the patches.  Especially if:

- You've had problems before; CardBus should work, and there were
    a bunch of bugfixes too.

- You're not using a NEC host controller:  Intel (ICH4), VIA
    (VT6202, VT8235), SIS (962, 963), NForce2, and so on.  If you
    have a newish motherboard, it may well have USB 2.0 built in.

- You want to use USB 1.1 interrupt transactions through USB 2.0
    hubs, such as for many HID devices, some Ethernet adapters, some
    disks, and so on.

The first patch does some minor updates to usbcore, which happens
to break the current 2.4.20-pre7 ehci-hcd code.

The second patch brings ehci-hcd up to the 2.5.34bk4 level, and
relies on that first patch.

- Dave







