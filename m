Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752509AbWJ0VmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbWJ0VmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbWJ0VmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:42:10 -0400
Received: from main.gmane.org ([80.91.229.2]:4813 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752509AbWJ0VmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:42:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: PnP Bios activation of parallel port prior to request_region
Date: Fri, 27 Oct 2006 21:38:37 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnek4vfg.39b.olecom@flower.upol.cz>
References: <200610260759.22237.dvhltc@us.ibm.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-26, Darren Hart <dvhltc@us.ibm.com> wrote:
> While working with a very simple demo parallel port interrupt driver, I found 
> that request_region() will successfully return, regardless of whether or not 
> the pnp calls have been made to activite the parallel port on a pnp system.  
>
> The driver worked by just calling request_region() on another system, but on 
> my laptop it wouldn't work unless I made the pnp activation calls before 
> hand.  The confusion came because the io range got assigned to my module, 
> showed up in /proc/ioports, etc.  So it appeared to be properly configured, 
> but all the inb() calls returned 0xff.
>
> I know have something working, but just wanted to ask if it is considered 
"now"?
> correct behavior for request_region() to succeed on an io range pertaining to 
> a device that needs to be initialized by the pnp system and hasn't been.

I know that legacy parallel port must work regadless of any parport
modules, using /dev/port and BIOS setup for EPP/ECP etc.

If you really want to be answered, try to address message (or cc) to
e-mails mentioned in
- `linux/MAINTAINERS.*PARALLEL PORT*'
- `linux/drivers/parport/parport_pc.c'
____

