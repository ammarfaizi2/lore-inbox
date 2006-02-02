Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWBBOlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWBBOlx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBBOlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:41:52 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25230 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751100AbWBBOlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:41:51 -0500
Subject: Re: calling bios interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jozef Kutej <jozef.kutej@slovanet.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43E1B93A.5000603@slovanet.net>
References: <43E1B93A.5000603@slovanet.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Feb 2006 14:43:28 +0000
Message-Id: <1138891408.9861.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-02 at 08:48 +0100, Jozef Kutej wrote:
> Hello.
> 
> Can someone help me solve my problem with on board watch dog timer that 
> need to call bios interrupt? Here's how to update watch dog timer.
> 
> mov ax,6f02h
> mov bl, 30	;number of seconds
> int 15h
> 
> How can i do this in kernel so that i can write wdt driver?

You need to drive the hardware directly. Ask the vendor for the hardware
info, or alternatively you might want to try using a library like lrmi
in user space to call it and log the I/O instructions it tries to
execute.


