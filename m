Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWJPKIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWJPKIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWJPKIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:08:16 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:10399 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030343AbWJPKIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:08:15 -0400
Subject: Re: [linux-usb-devel] [PATCH] usbmon: add binary interface
From: Marcel Holtmann <marcel@holtmann.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>, gregkh@suse.de,
       Paolo Abeni <paolo.abeni@email.it>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20061011142941.3c599e16.zaitcev@redhat.com>
References: <20061011134351.0c79445a.zaitcev@redhat.com>
	 <Pine.LNX.4.44L0.0610111649440.6437-100000@iolanthe.rowland.org>
	 <20061011142941.3c599e16.zaitcev@redhat.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 12:07:38 +0200
Message-Id: <1160993258.5498.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

> > Would relayfs be a better choice than debugfs for exporting potentially
> > large quantities of binary data?
> 
> I'm sick of mounting them, so for the binary API I was going to
> create a bunch of character devices with a dynamic major.
> With udev, I do not even need to read /proc/devices myself.
> 
> Curiously enough, Marcel Holtmann argued for a device because he
> did NOT want to run udev. Funny how that works.

can't remember that I said that. My concern was that distros might not
compile debugfs and so usbmon would have been useless. Some character
devices seems the right approach to me. The only concern with a dynamic
major might be USB debugging in an early time of the boot process, but
that seems to be really rare.

Regards

Marcel


