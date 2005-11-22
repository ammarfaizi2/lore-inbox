Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVKVTAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVKVTAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVKVTAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:00:10 -0500
Received: from havoc.gtf.org ([69.61.125.42]:9100 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965111AbVKVTAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:00:05 -0500
Date: Tue, 22 Nov 2005 14:00:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Gustavo Guillermo =?iso-8859-1?Q?P=E9rez?= 
	<gustavo@compunauta.com>,
       linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: /dev/sr0 not ready, but working
Message-ID: <20051122190005.GC6592@havoc.gtf.org>
References: <200511221143.00970.gustavo@compunauta.com> <Pine.LNX.4.44L0.0511221349360.21136-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511221349360.21136-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 01:56:39PM -0500, Alan Stern wrote:
> I know practically nothing about how your device works, so this is just a
> guess.  It seems likely that the IEEE1394-USB/ATA interface controller
> translates the commands it receives over the external bus into a sequence
> of ATA or ATAPI commands that is somewhat different from the sequence of
> commands Linux would use if the drive were directly attached to an IDE
> controller.  As a result, perhaps the drive sends those "not ready"  
> replies when you use it over an external bus but not when you use attach
> it over ATA.
> 
> Or maybe not...  Maybe the drive _does_ send those "not ready" messages 
> and the IDE driver ignores them instead of printing them in the system 
> log.  Or perhaps those messages are sent by the bus interface controller 
> and not by the drive itself.  I just don't know.

The difference is between ide-cd.c and sr.c, most likely.

	Jeff



