Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTL2S2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTL2S2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:28:10 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:55937
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263742AbTL2S2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:28:07 -0500
Date: Mon, 29 Dec 2003 13:38:12 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: =?iso-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-ID: <20031229133812.A4788@animx.eu.org>
References: <20031229173853.A32038@beton.cybernet.src> <20031229164539.GD30794@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20031229164539.GD30794@louise.pinerecords.com>; from Tomas Szepe on Mon, Dec 29, 2003 at 05:45:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it possible to boot kernel with root from /dev/sda1 (USB)?
> > partition table: whole /dev/sda is one partition (sda1), type 83 (Linux).
> > Tried also switching on and off hotplugging in kernel and it didn't help.
> 
> Well, is the device detected and the partition table scanned before the
> root mount is attempted?
> 
> I believe this should work given you've compiled in all the necessary
> code.  Please capture the dmesg using serial console/netconsole/whatever
> and post it along with your .config.

I did this with 2.4 a few months back.  Basically all I did was add the same
delay before mounting root as the kernel does with mounting a root floppy. 
Problem is the kernel is too fast for the usb code to find the disk.

I'v been wanting to ask this question.  How can I make the kernel "sleep"
for say 5 seconds (or pause or something, whatever is required to delay
execution) to wait for the device to become available.  I tried the same
thing doing nfsroot with a cardbus nic which fails because the kernel
doesn't see the card until after it attempted to mount /

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
