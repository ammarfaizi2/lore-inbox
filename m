Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTKNBVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 20:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTKNBVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 20:21:02 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:55480 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264489AbTKNBVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 20:21:00 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 hangs upon echo > /proc/acpi/alarm 
In-reply-to: Your message of "Fri, 14 Nov 2003 02:24:43 +0800."
             <200311140224.43459.mhf@linuxmail.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Nov 2003 12:20:03 +1100
Message-ID: <8828.1068772803@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Nov 2003 02:24:43 +0800, 
Michael Frank <mhf@linuxmail.org> wrote:
>I have two questions about kdb 3.0, x86 hw on 2.4.22 kernel

kdb 3.0 is ancient, current is kdb v4.3.

> - is there any netpoll interface for kdb for legacy free hw wo serial port.

No netpoll interface.  netpoll is not in the standard kernel, kdb
patches are only against the standard kernels.

For legacy free hardware, kdb v4.3 has a working USB keyboard polled
mode.  Build with

CONFIG_USB=y
CONFIG_USB_UHCI=y (or OHCI)
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_KBD=y
CONFIG_KDB_USB=y

> - on another non-acpi machine kdb hangs permanently and blinking kbleds stop once 
>    - any key is pressed on the at keyboard 
>    - after about a minute inside kdb (operating via serial port)

Sounds like kdb is itself dying.  Insufficient data to diagnose, in any
case there have been a lot of bug fixes and enhancements to kdb since
v3.0.

