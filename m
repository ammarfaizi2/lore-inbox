Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVA3Csx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVA3Csx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 21:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVA3Csx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 21:48:53 -0500
Received: from ernie.virtualdave.com ([198.216.116.246]:63501 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S261636AbVA3Csu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 21:48:50 -0500
Date: Sat, 29 Jan 2005 20:48:28 -0600 (CST)
From: David Sims <dpsims@virtualdave.com>
To: Jeff Garzik <jgarzik@pobox.com>, Jeremy Higdon <jeremy@sgi.com>,
       Paulo Marques <pmarques@grupopie.com>,
       Bukie Mabayoje <bukiemab@gte.net>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: I need a hardware wizard... I have been beating my head on the
 wall..
In-Reply-To: <41F99AF0.4090902@pobox.com>
Message-ID: <Pine.LNX.4.21.0501292024010.11121-100000@ernie.virtualdave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

  Now I _really_ need to bang my head on the wall... :( .... and thank all
you people who responded to my cry for help... I have to admit that I have
been stupid (or just a little clueless).... but I have worked the puzzle!!

  It seems that sata_vsc works just fine.... My entire problem involved
the PCI IRQ routing mechanism.... and my lack of understanding of the
interaction between 'Loacl APIC', 'IO-APIC' and power management.... It
seems that you can do what you want with 'Local APIC' and 'IO-APIC' but if
you have not enabled ACPI, the APIC stuff is not enabled... and doesn't
seem to do anything....

  I have now enabled both ACPI and APIC (with IO-APIC)  and the IRQ
barking has gone away!! 

  I had a similar problem today with another computer (ASUS
MS4800-MX) where the built in Ethernet on a Via PHY chip (supported by the
SiS900 driver) refused to work... In this case I booted up Knoppix which
worked just fine.... and then started trying to figure out why there was a
difference between knoppix and a vanilla Slackware kernel.... It seems
that Slackware 9.1 does not have ACPI (or APIC or IO-APIC) enabled... Once
I figured that out, it was seemed to make the SIS900 driver work so I
decided to try it on the sata_vsc problem.... The result is history and
everything is working as it should.... It's a shame that the knoppix 3.4
kernel doesn't probe for SATA stuff or I would probably have figured this
out a week ago :(

  Meanwhile, a working sata_vsc allows one to turn a Dell Powervault 745N
(Dell's foray into Network Attached Storage) into a good and cheap unix
server with dual gig NICs and 4 SATA disks that can either be run
independently or via software raid!! Cool!

Thanks again for your support for and patience with me... I will be humble
for a while now... ;)

Dave






