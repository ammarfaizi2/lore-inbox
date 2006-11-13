Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755185AbWKMQJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbWKMQJW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbWKMQJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:09:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64182 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755185AbWKMQJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:09:22 -0500
Date: Mon, 13 Nov 2006 16:11:30 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Pavel Machek <pavel@ucw.cz>, John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com, ak@suse.de
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
Message-ID: <20061113161130.02ba0c74@localhost.localdomain>
In-Reply-To: <45589008.1080001@garzik.org>
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org>
	<20061009215221.GC30702@elf.ucw.cz>
	<87ods6loe8.fsf-genuine-vii@john.fremlin.org>
	<20061025070920.GG5851@elf.ucw.cz>
	<87y7r3xlif.fsf-genuine-vii@john.fremlin.org>
	<20061026204655.GA1767@elf.ucw.cz>
	<87slgv6ccz.fsf-genuine-vii@john.fremlin.org>
	<20061112183614.GA5081@ucw.cz>
	<87hcx3adcd.fsf-genuine-vii@john.fremlin.org>
	<20061113142219.GA2703@elf.ucw.cz>
	<45589008.1080001@garzik.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 10:32:24 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Therein lies a key problem.  Turning on all of AHCI's aggressive power 
> management features DOES save a lot of power.  But at the same time, it 
> shortens the life of your hard drive, particularly hard drives that are 
> really PATA, but have a PATA<->SATA bridge glued on the drive to enable 
> connection to SATA controllers.

We already detect PATA over SATA so we can trivially address that (the
knobble check). Similarly we can turn ALPME on using a timer so it kicks
in after long idle periods only, or tie it to laptop mode.

For a laptop type environment with SATA not bridged PATA turning it on is
clearly the right thing to do.

Alan

