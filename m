Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269999AbUJEPzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269999AbUJEPzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269996AbUJEPzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:55:53 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:64426 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269970AbUJEPyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:54:32 -0400
Subject: Re: Core scsi layer crashes in 2.6.8.1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Mark Lord <lsml@rtr.ca>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <200410051749.22245.oliver@neukum.org>
References: <1096401785.13936.5.camel@localhost.localdomain>
	<4162B345.9000806@rtr.ca> <1096988167.2064.7.camel@mulgrave> 
	<200410051749.22245.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 Oct 2004 10:54:17 -0500
Message-Id: <1096991666.2064.25.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 10:49, Oliver Neukum wrote:
> Then let the driver tell the upper layers whether the device is still
> connected or not.

Do we have to go over this again?

It would add quite a bit of complexity to the reference counted
aynchronous model to try and force synchronicity between queuecommand
and scsi_remove_host in the mid-layer.  Therefore it's much easier to
let the LLD decide what to do with the command.

James


