Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWCCUKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWCCUKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWCCUKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:10:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932130AbWCCUKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:10:02 -0500
Date: Fri, 3 Mar 2006 12:09:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Steve Byan <smb@egenera.com>, Mark Lord <lkml@rtr.ca>,
       Matthias Andree <matthias.andree@gmx.de>,
       Douglas Gilbert <dougg@torque.net>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
In-Reply-To: <44089C34.2030604@garzik.org>
Message-ID: <Pine.LNX.4.64.0603031204370.22647@g5.osdl.org>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net>
 <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
 <4405E8AA.1090803@rtr.ca> <Pine.LNX.4.64.0603011036110.22647@g5.osdl.org>
 <CF493E39-B369-46D8-85EE-013F2484F1C6@egenera.com>
 <Pine.LNX.4.64.0603031035140.22647@g5.osdl.org> <44089C34.2030604@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Mar 2006, Jeff Garzik wrote:
> 
> 256 max sectors IDE driver, 200 max sectors libata (due to driver not
> hardware).

When I said "lower due to broken hw" I was more thinking about things like 
the SiIimage driver, which actually limits the rqsize to 15 sectors due to 
some strange hw interactions with seagate SATA devices.

(It will then raise it back up to 128 if it's not a Seagate SATA drive. I 
forget what the exact issue was. Some strange corruption in some limited 
case, and not allowing big requests worked around it. There's some 
strange IDE quirks out there...).

			Linus
