Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422779AbWBNUFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422779AbWBNUFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbWBNUFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:05:51 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14224 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422779AbWBNUFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:05:50 -0500
Subject: Re: PATCH: rio driver, boot code (1 of 3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, apkm@osdl.org
In-Reply-To: <200602141938.12041.s0348365@sms.ed.ac.uk>
References: <1139944938.11979.5.camel@localhost.localdomain>
	 <200602141938.12041.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 20:08:39 +0000
Message-Id: <1139947720.11979.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-14 at 19:38 +0000, Alistair John Strachan wrote:
> Missing semicolon, maybe lose the \ .
> 
> >  		}
> >
> >  		rio_dprintk (RIO_DEBUG_BOOT, "Running 0x%x\n",
> > RWORD(HostP->__ParmMapR)); @@ -528,7 +524,10 @@
> >  		if ( (RWORD(ParmMapP->links) & 0xFFFF) != 0xFFFF ) {
> >  			rio_dprintk (RIO_DEBUG_BOOT, "RIO Mesg Run Fail %s\n", HostP->Name);
> >  			rio_dprintk (RIO_DEBUG_BOOT, "Links = 0x%x\n",RWORD(ParmMapP->links));
> > -			HOST_DISABLE;
> > +			HostP->Flags &= ~RUN_STATE; \
> > +			HostP->Flags |= RC_STUFFED; \
> > +			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot);\ 
> > +			continue
> 
> Ditto.

Harmless but yes I'll send a diff to clean them up once the other three
are applied.


