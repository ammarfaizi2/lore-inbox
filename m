Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268854AbUHLXJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268854AbUHLXJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268876AbUHLXIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:08:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:4078 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268854AbUHLXHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:07:39 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Nathan Bryant <nbryant@optonline.net>, Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1092314892.1755.5.camel@mulgrave>
References: <4119611D.60401@optonline.net>
	 <20040811080935.GA26098@elf.ucw.cz>  <411A1B72.1010302@optonline.net>
	 <1092231462.2087.3.camel@mulgrave>  <1092267400.2136.24.camel@gaston>
	 <1092314892.1755.5.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1092351736.26430.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 09:02:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 22:48, James Bottomley wrote:
> On Wed, 2004-08-11 at 19:36, Benjamin Herrenschmidt wrote:
> > Some hosts will continuously DMA to memory iirc.. I remember having a
> > problem with 53c8xx on some macs when transitionning from MacOS to Linux
> > because of that.
> 
> I think you're thinking of the scripts engine?  on pre 53c875 chips,
> yes, this is true.  The on-board processor is executing instructions
> from host memory.  However, this is read only in quiescent (waiting for
> host connect or target reconnect) mode, so shouldn't be a problem for
> suspend.  On the 875 and later, we host the scripts in on-chip memory so
> they shouldn't be troubling main memory when idling.

The problem was a 875, the script was writing some kind of status or
whatever at regular interval to host memory. Might be specific to the
script used by the MacOS driver tho...

Ben.

