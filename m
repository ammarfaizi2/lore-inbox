Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTANR2P>; Tue, 14 Jan 2003 12:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbTANR2O>; Tue, 14 Jan 2003 12:28:14 -0500
Received: from [217.167.51.129] ([217.167.51.129]:64465 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S264836AbTANR2O>;
	Tue, 14 Jan 2003 12:28:14 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@redhat.com>
Cc: Ross Biro <rossb@google.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301131946.h0DJk1w32012@devserv.devel.redhat.com>
References: <200301131946.h0DJk1w32012@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042565893.587.66.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Jan 2003 18:38:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 20:46, Alan Cox wrote:
> > host shall wait 400 ns before reading the Status register. When entering 
> > this state from the HPIOI2 state, the host shall wait one PIO transfer 
> > cycle time before reading the Status register. The wait may be 
> > accomplished by reading the Alternate Status register and ignoring the 
> > result.
> 
> Fatal on PIIX PIO

Ok, but PIIX runs on intel platforms with real IOs, so there is no need
to perform a read... If we go the hwif->IOSYNC() way, we might well set
it up to no-op on x86 PIO iops by default and read of alt-status on
other archs if it's safe enough on other controllers/drives...

Ben.


