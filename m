Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269849AbUJEQaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269849AbUJEQaD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbUJEQ2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:28:21 -0400
Received: from mail1.kontent.de ([81.88.34.36]:33418 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269136AbUJEQ0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:26:14 -0400
From: Oliver Neukum <oliver@neukum.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Core scsi layer crashes in 2.6.8.1
Date: Tue, 5 Oct 2004 18:26:11 +0200
User-Agent: KMail/1.6.2
Cc: Mark Lord <lsml@rtr.ca>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1096401785.13936.5.camel@localhost.localdomain> <200410051801.03677.oliver@neukum.org> <1096992458.2173.35.camel@mulgrave>
In-Reply-To: <1096992458.2173.35.camel@mulgrave>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410051826.11892.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. Oktober 2004 18:07 schrieb James Bottomley:
> On Tue, 2004-10-05 at 11:01, Oliver Neukum wrote:
> > Why is it in any way difficult to decide whether to issue a command in the
> > first place? The command is generated upon being notified by the lower layer.
> > There is no issue of synchronisation here. It is simply stupid to give
> > commands that are bound to fail, if the information is already available.
> 
> a) we don't know that they are ... for notified ejection they will
> succeed.

Yes, that is why I proposed that you let the lower levels tell you whether
the devices in questions are still operative or not.

> b) The scsi bus is a scanned model ... drivers must be prepared to
> accept commands for non-existent devices. How does the removal case
> differ from the never present case?

It doesn't. But that doesn't explain why you want to issue the command
in all cases, even if we coule easily tell you whether it makes sense or
not? It makes no sense to me to throw away information you already have.

	Regards
		Oliver
