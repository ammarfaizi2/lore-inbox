Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVAJVPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVAJVPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVAJVFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:05:25 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:42316 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262514AbVAJUgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:36:08 -0500
X-Ironport-AV: i="3.88,113,1102312800"; 
   d="scan'208"; a="180141207:sNHT133796480"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UPkernel
Date: Mon, 10 Jan 2005 14:36:01 -0600
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D3C@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UPkernel
Thread-Index: AcT0ThjbFekIpUckQ8mrq8hWYhSXEQC/0/ng
From: <Tim_T_Murphy@Dell.com>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <rmk+lkml@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       <paulkf@microgate.com>
X-OriginalArrivalTime: 10 Jan 2005 20:36:01.0776 (UTC) FILETIME=[FFB73700:01C4F753]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your comments and advice, I am new to
the kernel and appreciate your taking the time.

> Presumably this is a device with a fake 8250 that 
> produces sudden large bursts of data ? If so then 
> for now you -need- to set low_latency and should 
> probably do it by the PCI vendor subid/device id. 
> The problem is that the serial layer expects serial 
> data arriving at serial speeds. It completely breaks 
> down when it hits an emulation of a generic uart that
> suddenely receives 32Kbytes of data at ethernet speed.

Yes. Thanks, this confirms what I suspected.

> The longer term fix for this is when the flip buffers
> go away, and the same problem gets cleaned up for 
> things like mainframes and some high performance DMA 
> devices. 

Is this, or a short-term fix, expected anytime soon?

Problem for me is that my application no longer works
with the 2.6 kernels, since it relies on the kernel's
serial support -- which worked fine with 2.4 kernels.

If there's anything I can do to expedite a fix please
let me know -- I've spent the past few days learning
and working with the code, but I obviously have a 
ways to go before I sleep..

Tim
