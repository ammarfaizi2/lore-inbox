Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUC3Hsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbUC3Hsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:48:41 -0500
Received: from quechua.inka.de ([193.197.184.2]:18670 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263360AbUC3Hqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:46:49 -0500
Subject: Re: [Swsusp-devel] [PATCH 2.6]: suspend to disk only available if
	non-modular IDE
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: ncunningham@users.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1080629551.12019.12.camel@laptop-linux.wpcb.org.au>
References: <200403282136.55435.arekm@pld-linux.org>
	 <1080517040.2223.3.camel@laptop-linux.wpcb.org.au>
	 <1080517591.5047.10.camel@laptop-linux.wpcb.org.au>
	 <pan.2004.03.29.21.34.45.973137@dungeon.inka.de>
	 <1080629551.12019.12.camel@laptop-linux.wpcb.org.au>
Content-Type: text/plain
Message-Id: <1080631869.1118.12.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 09:31:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[currently no scsi support]
ah, ok. 

> > btw: would it be somehow possible to resume after initrd phase?
> > or some other idea how a generic kernel with modules in the initrd
> > could use suspend to disk? or a laptop where the initrd is needed
> > to setup a dm-crypt volume with the right decrypton key?
> 
> That should be doable, provided that the initrd doesn't mount anything.
> Decryption is 'interesting'. The key needs to be set up in the resumed
> kernel too. (Shouldn't be a problem, if you manage to suspend to it!).

I don't know if loading modules can be done without, but the usual way
is to mount /sys and /proc so you can see what hardware is available.

I do that too for my dm-crypt setup, even mount a tmpfs at /dev,
create devices, start usb hotplugging, etc. but after getting the
decryption key, all filesystems are unmounted again, all processes
killed, there is nothing visible to me left. would that still create
some problems in the kernel internals preventing resume (or making it
too hard to do)?

Regards, Andras

