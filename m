Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267747AbUHEUTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267747AbUHEUTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbUHEUTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:19:05 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:1932 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S267747AbUHEUTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:19:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16658.38447.591862.21787@gargle.gargle.HOWL>
Date: Thu, 5 Aug 2004 16:18:55 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: caleb_gibbs@sbcglobal.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire hard drives 
In-Reply-To: <200408051612.36445.caleb_gibbs@sbcglobal.net>
References: <200408051612.36445.caleb_gibbs@sbcglobal.net>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Caleb> Has anyone had any luck getting there external firewire hard
Caleb> drive to mount?  my laptop is running suse9.0 and detects the
Caleb> firewire hub and works great with my usb devices but when I
Caleb> plug in the firewire hdd it boots the device but I can`t mount
Caleb> it.

I've been having problems too with these devices.  I've been trying
with a dual interface USB2.0/Firewire box with a Prolific Technology
chipset.  This is with 2.6.[678]-* kernels of various types.  I can do
a mkfs under either USB2 or Firewire connections (both ports are on
the same Adaptec PCI card) but the firewire sides bombs out much
quicker.  

I've just found some issues with Device Mapper and MD that I wonder
might be causing some issues here, but if I use the USB side, I get
full system lockups at points which are not fun, while on the Firewire
side I get tons of errors and the device (drive and case) just lock up
completely.  Takes a power cycles and a couple of un-plugs to get it
working again under Firewire.  

I've filed a bug report with the linux-ieee1394 folks, but I haven't
had a chance to look into it yet to provide more info if they've
requested it.

Sorry, not much else to report here, but I'd certainly like to help out.

John
