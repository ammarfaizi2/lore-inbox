Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWBJSKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWBJSKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWBJSKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:10:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54995 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932163AbWBJSKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:10:34 -0500
Subject: Re: Let's get rid of  ide-scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Greg KH <greg@kroah.com>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060210173110.GA29028@animx.eu.org>
References: <20060210002148.37683.qmail@web50201.mail.yahoo.com>
	 <20060210003614.GA26114@animx.eu.org> <20060210052404.GB29421@kroah.com>
	 <20060210121107.GC27814@animx.eu.org> <20060210163114.GA26203@kroah.com>
	 <20060210173110.GA29028@animx.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Feb 2006 18:12:54 +0000
Message-Id: <1139595174.12521.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-02-10 at 12:31 -0500, Wakko Warner wrote:
> If/When libata takes over ide in general, how many of these machine will
> then require the scsi layer?  I would think all systems would except ones
> without internal disks (non-usb/firewire).

You'll want libata (but not eventually all of the scsi layer) for just
about anything at that point. On the bright side you won't have scsi
loaded for your USB devices and drivers/ide loaded for your IDE disks so
for most cases I suspect it will be neutral or save memory.

If you are really tighht on memory and just using CF then its probably
worth writing a simple CF driver for embedded use. Its probably a matter
of 10K of code if that for the subset in question.

