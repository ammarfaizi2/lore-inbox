Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270548AbUJTUr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270548AbUJTUr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUJTUnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:43:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:27099 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269908AbUJTUnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:43:00 -0400
Subject: Re: 2.6.7, amd64: PS/2 Mouse detection doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <417660AE.4060408@t-online.de>
References: <40F0E586.4040000@t-online.de> <20040711084208.GA1322@ucw.cz>
	 <417660AE.4060408@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098301207.12411.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 20:40:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-20 at 13:57, Harald Dunkel wrote:
> Hi folks,
> 
> Attached you can find an updated patch for 2.6.9.

You need to handle the USB reset quirks for OHCI and also catch any
escaped interrupts. It also seems you have to deal with UHCI (at least
my E750x fixes arent sufficient with a keyboard on an EHCI hub)

