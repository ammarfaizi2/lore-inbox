Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSIAKgu>; Sun, 1 Sep 2002 06:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSIAKgu>; Sun, 1 Sep 2002 06:36:50 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:35244 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S316608AbSIAKgt>; Sun, 1 Sep 2002 06:36:49 -0400
Date: Sun, 1 Sep 2002 12:41:12 +0200
Message-Id: <200209011041.g81AfBX05372@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <joerg.beyer@email.de>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: setpci is no changing values
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joerg.beyer@email.de schrieb am 31.08.02 23:14:39:
> Hi,
> 
> I have some trouble with a laptop's NIC (it's a 8139C realtek chip, I use the rtl8139 module). With
> a lot help I think the problem is tracked down to a problem with the PCI bus bandwidth.
...
With the help of Mark Hahn I figuerd out, that the problem was the Bridge
setting, not the NIC setting.

The VT8363/8365 Bridge was blocking/slowing down the bus. 
After allowing this device to do fast back-to-back writes 
it works _much_ better, i.e. no more errors on the NIC.

If I encounter no negative effects of this setting, then I consider
this a working setup.

    Thank you very much for you help!
    Joerg




