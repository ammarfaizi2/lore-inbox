Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWFWS3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWFWS3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWFWS3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:29:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45537 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751897AbWFWS3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:29:33 -0400
Subject: Re: cmd64x not happy about being hotplugged, 2.6.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Josh Litherland <josh@temp123.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <449C0A3B.6070409@temp123.org>
References: <449C0A3B.6070409@temp123.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 19:45:13 +0100
Message-Id: <1151088313.4549.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-23 am 11:35 -0400, ysgrifennodd Josh Litherland:
> I have a thinkpad dock 2 which includes a Silicon Image CMD648 IDE 
> controller (1095:0648 (rev 01)) for the UltraBay2000 slot.  The dock now 
> works as an acpiphp PCI hotplug device, and the PCI devs get detected 

drivers/ide does not support hotplug except in 2.4-ac and sort-of (if
the device is closed entirely) in Red Hat Enterprise Linux 4. You'll
have to ask Bartlomiej if he has any plans to fix that for 2.6 proper.

The new libata layer has hotplug work afoot which should deal with this,
although the CMD648 driver for it is very experimental as the 648 is
pretty rare nowdays

Alan

