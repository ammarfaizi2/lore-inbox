Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268610AbUHLQqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268610AbUHLQqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268611AbUHLQqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:46:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33701 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268610AbUHLQq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:46:28 -0400
Date: Thu, 12 Aug 2004 09:45:57 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Nathan Bryant <nbryant@optonline.net>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SCSI midlayer power management
Message-ID: <20040812164557.GA16852@beaverton.ibm.com>
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net> <1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston> <1092314892.1755.5.camel@mulgrave> <411B736C.7030103@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411B736C.7030103@optonline.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 09:41:00AM -0400, Nathan Bryant wrote:
> James Bottomley wrote:
> 
> >Why?  We don't do a bus reset on boot, why should we need to do one on
> >resume?  For FC, the equivalent, a LIP Reset can be rather nasty on a
> >SAN and should be avoided.
> > 
> >
> that can be host specific. aic7xxx does a bus reset on boot, so i 
> preserved this on resume.

It can be changed via the "no_reset" option, that should probably be
honored for resume.

> don't know why they do it, but they do.

I used to use no_reset, as well as bios no reset (or is it no spin up?) to
decrease boot time, until a crash hung the bus and the system could not
boot. I suppose letting the bios reset would have gotten around the
problem, I can't remember.

-- Patrick Mansfield
