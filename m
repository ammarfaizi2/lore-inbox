Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTJSRmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTJSRmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:42:38 -0400
Received: from main.gmane.org ([80.91.224.249]:22955 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262068AbTJSRmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:42:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: HighPoint 374
Date: Sun, 19 Oct 2003 19:42:33 +0200
Message-ID: <yw1x3cdpgm46.fsf@users.sourceforge.net>
References: <00b801c3955c$7e623100$0514a8c0@HUSH> <1066579176.7363.3.camel@milo.comcast.net>
 <41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:vbpwN6AdV4qfRufq4VrYoCcOum0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi> writes:

>> In 2.4.21 and 2.4.22 it's working great for me.  I'm using the
>> "experimental" IDE Raid with two disks on a HPT 374 controller with the
>> drivers that come with the kernel.
>
> I have tried these versions in the past as well without success.
> However, I don't use HPT-raid features at all ie. I'm using the
> disks as JBOD. What hardware do you have and have you enabled
> ACPI/local-apic/io-apic ? What brand & model of disk-drives you
> are using with HPT374 controller ? And finally what does
> the /proc/interrupts show for you ?

I'm using a RocketRAID 1540 SATA card (hpt374 based) in an Alpha
system.  It has no such thing as ACPI.  The disks are four Seagate
Barracuda 7200.7 running software raid5.  My /proc/interrupts:

  1:      11440          XT-PIC   keyboard
  2:          0          XT-PIC   cascade
  8:  179530685             RTC  +timer
 14:        198          XT-PIC  +ide0
 15:         11          XT-PIC  +ide1
 22:          0             SRM   timer-cascade
 24:          0             SRM   usb-ohci
 25:    2327086             SRM  +CMI8738-MC6
 26:    4198981             SRM   ide2,  ide3,  ide4,  ide5
 28:      92591             SRM   usb-ohci
 32:   21577855             SRM   ehci-hcd
ERR:          0

The hpt374 is on IRQ 26.

-- 
Måns Rullgård
mru@users.sf.net

