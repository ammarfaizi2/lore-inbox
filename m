Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272393AbTHIPBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272395AbTHIPBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:01:40 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:15113 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272393AbTHIPBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:01:37 -0400
Date: Sat, 9 Aug 2003 17:01:32 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Phoenix <phoenix@comms.engg.susx.ac.uk>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] usb-storage: WIN_SECURITY_UNLOCK
Message-ID: <20030809170132.A8883@pclin040.win.tue.nl>
References: <Pine.LNX.4.44.0308091352350.7461-100000@engg101-57.comms.engg.susx.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308091352350.7461-100000@engg101-57.comms.engg.susx.ac.uk>; from phoenix@comms.engg.susx.ac.uk on Sat, Aug 09, 2003 at 02:00:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 02:00:06PM +0100, Phoenix wrote:

> Is it possible to send ATAPI commands to usb-storage hard-disks, like
> WIN_SECURITY_UNLOCK, through the scsi inteface?
> 
> I have an ALI5621 chipset that supports SCSI transparent command set
> only and I didn't find anything in SCSI-2 that is related to the ATAPI
> security features.

I think the general answer will be No.

A similar question is whether ide-floppy is superfluous and one can
do everything via ide-scsi. Again I think the answer will be No.

Indeed, ide-scsi uses the Packet command A0 of ATAPI to send
SCSI command packets to the ATAPI device. But there is no reason
to expect that all ATAPI commands are covered this way.
The first example is already A1: IDENTIFY PACKET DEVICE.
SCSI has INQUIRY, but that is not the same.

I have some ancient patches to ide-floppy.c that allow one
to switch an Iomega ZIP drive between large floppy and removable disk.
I do not know of a way to send these same commands via ide-scsi.

Andries

