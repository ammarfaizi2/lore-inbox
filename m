Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUDVU4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUDVU4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264676AbUDVUz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:55:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264673AbUDVUyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:54:35 -0400
Date: Thu, 22 Apr 2004 16:54:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@ucw.cz>
cc: Nick Popoff <cryptic-lkml@bloodletting.com>, linux-kernel@vger.kernel.org
Subject: Re: Testing Dual Ethernet via Loopback
In-Reply-To: <20040420192637.GD1413@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.53.0404221652330.940@chaos>
References: <200404190614.21764.cryptic-lkml@bloodletting.com>
 <20040420192637.GD1413@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Pavel Machek wrote:

> Hi!
>
> > So what I'm wondering is if there is a way to force Linux to actually
> > utilize its network hardware in sending these packets to itself?  In other
> > words, a ping or file transfer from an IP assigned to eth0 to another IP
> > assigned to eth1 should fail if I unplug the network cable connecting the
> > two.  Any advice on this would be much appreciated.  I'm not afraid of
> > reading kernel source but have no idea where to start on this one.

`ifconfig lo down` should do it. This will (should) force linux
to actually use the address supplied and not sneak through the
loopback device.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


