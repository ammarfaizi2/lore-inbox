Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVAJSbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVAJSbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVAJSY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:24:28 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:49186 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262390AbVAJSDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:03:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fYQny538bGDBbGQLK6OKg0CSpZRatDl6AIDmmjW4hW+MmOEofEOwGDUNXVY/jH+T7syhM+wWhbHs/HSu1CEfiVzdgNm8eQXB93uibc+X07iy1Z+JU3NxTA1NayGwwru5hG3E7Jgq/eUC9rs5HJBKft6MqKTDAm0d07Y5AXu6zCE=
Message-ID: <884a349a050110100347dfc583@mail.gmail.com>
Date: Mon, 10 Jan 2005 19:03:12 +0100
From: Roseline Bonchamp <roseline.bonchamp@gmail.com>
Reply-To: Roseline Bonchamp <roseline.bonchamp@gmail.com>
To: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
Subject: Re: [Linux-usb-users] USB problem with a mass storage device on 2.6.10
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0501100752270.5108@antonia.sgowdy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <884a349a050110044654d75f7b@mail.gmail.com>
	 <Pine.LNX.4.58.0501100752270.5108@antonia.sgowdy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is in /proc/bus/usb/devices when it doesn't work (and when it works)?
> What command fails?

When it does'nt work, I see my 2 UHCI controllers and my EHCI
controller (driver=Hub)

When it does work, I see the same, plus:

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 15 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0ea0 ProdID=2168 Rev= 2.00
S:  Manufacturer=USB
S:  Product=Flash Disk
S:  SerialNumber=106C1141B1C3762C
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=200mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=125us

What fails is that I don't see anything related to USB mass storage in
logs, and so cannot access the device through de SCSI interface
(/dev/sda...)

Also I've just fount out that it seems that "echo y >
/sys/module/usbcore/parameters/old_scheme_first" makes it work!
