Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269922AbUJEQTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269922AbUJEQTC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270163AbUJEQJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:09:50 -0400
Received: from mail1.kontent.de ([81.88.34.36]:39074 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269992AbUJEQBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:01:12 -0400
From: Oliver Neukum <oliver@neukum.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Core scsi layer crashes in 2.6.8.1
Date: Tue, 5 Oct 2004 18:01:03 +0200
User-Agent: KMail/1.6.2
Cc: Mark Lord <lsml@rtr.ca>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1096401785.13936.5.camel@localhost.localdomain> <200410051749.22245.oliver@neukum.org> <1096991666.2064.25.camel@mulgrave>
In-Reply-To: <1096991666.2064.25.camel@mulgrave>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410051801.03677.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. Oktober 2004 17:54 schrieb James Bottomley:
> On Tue, 2004-10-05 at 10:49, Oliver Neukum wrote:
> > Then let the driver tell the upper layers whether the device is still
> > connected or not.
> 
> Do we have to go over this again?
> 
> It would add quite a bit of complexity to the reference counted
> aynchronous model to try and force synchronicity between queuecommand
> and scsi_remove_host in the mid-layer.  Therefore it's much easier to
> let the LLD decide what to do with the command.

Why is it in any way difficult to decide whether to issue a command in the
first place? The command is generated upon being notified by the lower layer.
There is no issue of synchronisation here. It is simply stupid to give
commands that are bound to fail, if the information is already available.

	Regards
		Oliver
