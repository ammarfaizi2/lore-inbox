Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSLWO3h>; Mon, 23 Dec 2002 09:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbSLWO3h>; Mon, 23 Dec 2002 09:29:37 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:51916 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S265336AbSLWO3g>; Mon, 23 Dec 2002 09:29:36 -0500
Subject: Re: ATI Radeon IGP 320M and Kern. 2.4.21-pre2 Warnings/Problems...
From: Roel Teuwen <Roel.Teuwen@advalvas.be>
To: "Mark F." <daracerz@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1040658387.608.13.camel@tux3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 23 Dec 2002 16:46:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-23 at 04:40, Mark F. wrote:
> Hello

Hi Mark,

> In trying to help out the issue with the Radeon IGP Chipsets, I have posted 
> out the problems that occured on my system.  This is a Readon IGP 320M chip, 
> running on a Compaq 900Z.  BTW, these logs don't include loading sound 
> driver.  Sound driver cause the my hda, hdc links to timeout, and the hard 
> drives are completely inaccesable till i remake kernel without them.
> 

I have succeeded in loading the sound drivers after removing line 3379
from trident.c :

pci_write_config_byte(pci_dev, 0xB8, ~temp);

As described on :

http://marc.theaimsgroup.com/?l=linux-kernel&m=103962262721310&w=2

I'm not sure about your other problems, but adding the ACPI patch (and
enabling it), enabling Local APIC and IO-APIC for single processor fixed
all other problems I saw with this laptop (not sure which of these
options was the key). I still use the vesa driver for XFree86 though.

Best regards,

Roel

