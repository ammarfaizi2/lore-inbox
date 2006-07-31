Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWGaXNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWGaXNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWGaXNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:13:42 -0400
Received: from old-tantale.fifi.org ([64.81.251.130]:45450 "EHLO
	tantale.fifi.org") by vger.kernel.org with ESMTP id S1751404AbWGaXNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:13:41 -0400
To: Patrick Mau <mau@oscar.ping.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question about "Not Ready" SCSI error
References: <20060730181014.GA13456@oscar.prima.de>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 31 Jul 2006 16:13:34 -0700
In-Reply-To: <20060730181014.GA13456@oscar.prima.de>
Message-ID: <877j1tid0h.fsf@tantale.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mau <mau@oscar.ping.de> writes:

> Hallo everyone
> 
> Today one of my SCSI drives decided to shutdown for no obvious reason.
> I suspect heat or a bad power supply. Syslog shows a repeating stream
> of the following:
> 
> Jul 30 15:51:30 tony kernel: sd 0:0:0:0: Device not ready: <6>: Current: sense key=0x2
> Jul 30 15:51:30 tony kernel: ASC=0x4 ASCQ=0x2
> Jul 30 15:51:30 tony kernel: end_request: I/O error, dev sda, sector 617358
> 
> Google revealed[1] that the drive is waiting for a START UNIT command,
> but it seems that the kernel is not attempting to spin up the drive
> again. 
> 
> After a complete power-cycle the drive worked again. I just wanted to
> know if this is a shortcoming in the SCSI error handling codepath.

I'll have to report that I've seen a few drives behaving similarly,
both on 2.4.x and 2.6.x.

Is that an expected behavior from SCSI hard drives?  Any SCSI guru
would be able to answer this one?

Phil.

