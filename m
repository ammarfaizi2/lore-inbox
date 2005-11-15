Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVKOU7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVKOU7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVKOU7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:59:35 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:63031 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750743AbVKOU7e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:59:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BLo2rPFRgY7w4gcSYND416OwDhK7HwPEdIm9N5pgC016pTFiU62u5tYGgwNJi22F+yZOg17PyZpa5BE/j9KdS76TDpHnaAoNgwfyhnHX0bWSZtgASO0XiT0UugMqMIDa/3w0zVfgAdYnxcezoDk0cxWGZuOqBfO6ITM585j/1Jc=
Message-ID: <58cb370e0511151259x467172bfqbd888d9d0da9edf8@mail.gmail.com>
Date: Tue, 15 Nov 2005 21:59:33 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bryce Nesbitt <bryce1@obviously.com>
Subject: Re: ide: failed opcode errors, thousands of them, 2.6.13-15
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0511150846r5f8c89aagddf902e9b6ab6361@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43784187.4060607@obviously.com>
	 <58cb370e0511150846r5f8c89aagddf902e9b6ab6361@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 11/14/05, Bryce Nesbitt <bryce1@obviously.com> wrote:
> > This is using a SUSE Linux 10.0 build.  I installed a new DVD burner,
> > and now get 1 error per second in
> > the kernel ring buffer:
> >
> > Nov 13 23:31:18 linux kernel: hdc: packet command error: status=0x51 {
> > DriveReady SeekComplete Error }
> > Nov 13 23:31:18 linux kernel: hdc: packet command error: error=0x54 {
> > AbortedCommand LastFailedSense=0x05 }
> > Nov 13 23:31:18 linux kernel: ide: failed opcode was: unknown
> > Nov 13 23:31:19 linux udevd[2297]: get_netlink_msg: no ACTION in payload
> > found, skip event 'mount'
> > Nov 13 23:31:19 linux kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
> > Nov 13 23:31:19 linux kernel: ISO 9660 Extensions: RRIP_1991A
> > Nov 13 23:31:19 linux kernel: hdc: packet command error: status=0x51 {
> > DriveReady SeekComplete Error }
> > Nov 13 23:31:19 linux kernel: hdc: packet command error: error=0x54 {
> > AbortedCommand LastFailedSense=0x05 }
> > Nov 13 23:31:19 linux kernel: ide: failed opcode was: unknown
> > Nov 13 23:31:20 linux kernel: hdc: packet command error: status=0x51 {
> > DriveReady SeekComplete Error }
> > Nov 13 23:31:20 linux kernel: hdc: packet command error: error=0x54 {
> > AbortedCommand LastFailedSense=0x05 }
> > Nov 13 23:31:20 linux kernel: ide: failed opcode was: unknown
> >
> > This is similar to report:
> > http://lkml.org/lkml/2005/9/21/300  DMA broken in mainline 2.6.13.2
> > _AND_ opensuse vendor 2.6.13-15

This bug is confirmed to be fixed in 2.6.14 by the original reported.

> > Like the first reporter, I also have a LITEON SOHW-1693S DVD burner.
> > Curiously enough mine works fine (burns and reads DVD's just fine).
> > DMA on or DMA off makes no difference.
> > Note the HDIO_GETGEO error below.
> > Is there anything else I can probe to help track down this issue?
>
> Try latest _vanilla_ kernel (2.6.15-rc1), if it still doesn't work
> please fill the bug on http://bugme.osdl.org.
