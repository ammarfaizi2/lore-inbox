Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVAOBfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVAOBfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVAOBcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:32:36 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:55901 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262069AbVAOBbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:31:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org,
       Matthew Harrell 
	<mharrell-dated-1106175998.ed30bc@bittwiddlers.com>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Fri, 14 Jan 2005 20:31:09 -0500
User-Agent: KMail/1.6.2
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501122242.51686.dtor_core@ameritech.net> <20050114230637.GA32061@bittwiddlers.com>
In-Reply-To: <20050114230637.GA32061@bittwiddlers.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501142031.10119.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 January 2005 06:06 pm, Matthew Harrell wrote:
> To qualify that more, the same setup used to compile 2.6.10, 2.6.10-mm2,
> 2.6.10-mm3, 2.6.11-rc1 only gives me a working keyboard and mouse on the
> 2.6.10 kernel.

Hi,

your scenario is a bit different, it looks like the controller does not want
to response right from the beginning (while on Roey's box kernel detects both
keyboard and mouse just fine):
 
> ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
> ACPI: PS/2 Mouse Controller [PS2M] at irq 12
> i8042.c: Can't read CTR while initializing i8042.

Could you try booting with acpi=off and without PNP compiled in? And maybe
with pci=routeirq

Also, there is a patch my Alan Cox dealing with legacy emulation (but note
that first part (udelay(50)) has already been applied:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109096903809223&q=raw

-- 
Dmitry
