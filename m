Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbSJOPmh>; Tue, 15 Oct 2002 11:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbSJOPmh>; Tue, 15 Oct 2002 11:42:37 -0400
Received: from x101-186-76-dhcp.reshalls.umn.edu ([128.101.186.76]:128 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S264665AbSJOPmg>;
	Tue, 15 Oct 2002 11:42:36 -0400
Date: Tue, 15 Oct 2002 10:53:24 -0500
To: linux-kernel@vger.kernel.org
Subject: (Mouse-related?) X hang 2.5.42-mm3
Message-ID: <3DAC39F4.mail6911JSYC@arashi.yi.org>
User-Agent: nail 10.0 9/29/02
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: arashi@arashi.yi.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running XFree86 4.2.1 (kernel Radeon drivers, no nvidia here), and
it will occasionally hang if I switch from X to (say) tty2 and then back.
This is the last thing that shows up in my log before the system hangs,
it seems to happen sometime between when I hit Alt-F7 and when the hang
sets in:

arashi kernel: drivers/usb/host/uhci-hcd.c: uhci_destroy_urb_priv: urb df611744 still on uhci->urb_list or uhci->remove_list

The only USB device I've got plugged in is my mouse. No gpm, I'm using
X's USBMouse driver.

This happens somewhat randomly, but I've been able to reproduce it by
switching in and out of X a lot of times, and eventually it hangs.

Matt
