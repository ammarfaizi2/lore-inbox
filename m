Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUHGXZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUHGXZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHGXZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:25:07 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39364 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264668AbUHGXYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:24:25 -0400
Subject: Re: [linux-usb-devel] USB shared interrupt problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20040806134230.5b05bca0@lembas.zaitcev.lan>
References: <5F106036E3D97448B673ED7AA8B2B6B30154AFED@scl-exch2k.phoenix.com>
	 <20040806134230.5b05bca0@lembas.zaitcev.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091917299.19077.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 23:21:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 21:42, Pete Zaitcev wrote:
> I have a patch which prevents SMM BIOS from doing this to us
> by requesting unconditional handoff (it comes from Vojtech @SuSE,
> modified by John Stulz from IBM for 2.4). However, if you have a "normal"
> BIOS doing this, I'm a little lost as to what to do. It can still honor
> the handoff, if you're lucky.

In SMM mode the USB controller isn't connected to the PCI IRQ line. That
is one thing that is done in the changeover. It also seems to be causing
problems with EHCI hand over on NVidia boards still.

BTW the patch wants extending by someone to cover EHCI - modern boards
are doing EHCI USB legacy now.

Alan

