Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268365AbTAMV7L>; Mon, 13 Jan 2003 16:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268366AbTAMV7K>; Mon, 13 Jan 2003 16:59:10 -0500
Received: from AMarseille-201-1-3-195.abo.wanadoo.fr ([193.253.250.195]:44144
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268365AbTAMV7D>; Mon, 13 Jan 2003 16:59:03 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: root@chaos.analogic.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Ross Biro <rossb@google.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1030113162939.30920A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1030113162939.30920A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042495640.587.30.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Jan 2003 23:07:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 22:40, Richard B. Johnson wrote:

> There is a well-defined procedure for this. Any "read" anywhere
> in the PCI address space, will force all posted writes to complete.
> However, the "read" will not be the data one would obtain after
> the write completes. 

Just to avoid confusion, the above is obviously wrong, the read will
indeed force pending store queues to complete _in order_, the read will
reach the device after the stores are complete and you'll read the value
you would get after the write normally. At least on PCI ;)

Ben.

