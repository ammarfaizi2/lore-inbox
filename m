Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269158AbUJEQAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269158AbUJEQAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270084AbUJEPv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:51:56 -0400
Received: from mail1.kontent.de ([81.88.34.36]:17895 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269934AbUJEPtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:49:36 -0400
From: Oliver Neukum <oliver@neukum.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Core scsi layer crashes in 2.6.8.1
Date: Tue, 5 Oct 2004 17:49:14 +0200
User-Agent: KMail/1.6.2
Cc: Mark Lord <lsml@rtr.ca>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1096401785.13936.5.camel@localhost.localdomain> <4162B345.9000806@rtr.ca> <1096988167.2064.7.camel@mulgrave>
In-Reply-To: <1096988167.2064.7.camel@mulgrave>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410051749.22245.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. Oktober 2004 16:56 schrieb James Bottomley:
> On Tue, 2004-10-05 at 09:44, Mark Lord wrote:
> > There seem to be other holes/races in this and related code.
> > 
> > The QStor driver implements hot insertion/removal of drives.
> > 
> > One thing it has to cope with at present is, after notifying
> > the mid-layer that a drive has been removed, the mid-layer calls
> > back with a synchronize-cache command for that drive..
> 
> This is expected behaviour.  For orderly removal an cache sync command
> must be sent to drives with a writeback cache before they're powered
> down.  For forced ejection, the driver has to error the command.

Then let the driver tell the upper layers whether the device is still
connected or not.

	Regards
		Oliver
