Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUCBLkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUCBLkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:40:43 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:42634 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261622AbUCBLkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:40:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, AlberT@SuperAlberT.it
Subject: Re: Synaptics and USB mouse conflict at boot time !?
Date: Tue, 2 Mar 2004 06:40:27 -0500
User-Agent: KMail/1.6
References: <200403021103.54310.AlberT@SuperAlberT.it>
In-Reply-To: <200403021103.54310.AlberT@SuperAlberT.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403020640.30354.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 March 2004 05:03 am, Emiliano 'AlberT' Gabrielli wrote:
> 
> Hi all,
> 	 I have a strange behaviour on my laptop: touchpad is not probed by the
> kernel (2.6.3) *if* and only if at boot time the USB mouse is plugged in ...

It is usually caused by USB Legacy emulation - BIOS makes a USB mouse look
like a PS/2 mouse. Look in your BIOS setup if there is an option to turn it
off. Otherwise you will have to load ehci/uhci_hcd and hid modules before
loading psmouse module as loading full-blown USB support disables that
emulation.

-- 
Dmitry
