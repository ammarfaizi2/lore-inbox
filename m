Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269175AbUJERAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbUJERAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269171AbUJEQ7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:59:35 -0400
Received: from havoc.gtf.org ([69.28.190.101]:6079 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269116AbUJEQ7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:59:13 -0400
Date: Tue, 5 Oct 2004 12:53:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Lord <lsml@rtr.ca>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Oliver Neukum <oliver@neukum.org>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Core scsi layer crashes in 2.6.8.1
Message-ID: <20041005165323.GA24922@havoc.gtf.org>
References: <1096401785.13936.5.camel@localhost.localdomain> <4162B345.9000806@rtr.ca> <1096988167.2064.7.camel@mulgrave> <200410051749.22245.oliver@neukum.org> <1096991666.2064.25.camel@mulgrave> <4162C474.8010505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4162C474.8010505@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 11:57:40AM -0400, Mark Lord wrote:
> James Bottomley wrote:
> >
> >It would add quite a bit of complexity to the reference counted
> >aynchronous model to try and force synchronicity between queuecommand
> >and scsi_remove_host in the mid-layer.  Therefore it's much easier to
> >let the LLD decide what to do with the command.
> 
> Presumably the same is also true for scsi_remove_device() ?

What I do in my local hotplug code is assume that the SCSI layer will be
stupid and send commands after I call scsi_remove_device(), for an
indeterminant but short period of time.

	Jeff



