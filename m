Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUFHPhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUFHPhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUFHPhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:37:36 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:2494 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S265222AbUFHPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:37:33 -0400
Message-ID: <40C5DD8E.8DD37D16@nospam.org>
Date: Tue, 08 Jun 2004 17:38:54 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Who owns those locks ?
References: <40A1F4BE.4A298352@nospam.org> <200406070906.54132.bjorn.helgaas@hp.com> <40C572C8.20B13640@nospam.org> <200406080905.52673.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> 
> On Tuesday 08 June 2004 2:03 am, Zoltan Menyhart wrote:
> > - You keep my code, it is correct for a memory size up to 16 Tbytes.
> 
> Many if not most large machines have sparse address spaces,
> so you may have memory at an address that will cause a
> problem even if the actual amount of memory is much smaller.
> 
> The main point is that I wouldn't want a time bomb that
> will silently fail when somebody happens to boot on such
> a machine.  Whether that's avoided by a "miraculous" bit,
> throwing away problem pages at boot-time, avoiding task
> allocation at specific addresses, etc.,  is secondary.

I see.
No use to make it too much complicated.
There is always the option CONFIG_DEBUG_SPINLOCK.

On our no-more-than-512-Gbyte-machine, this small stuff
"saved my life" twice.
I just wanted to share it...

Regards,

Zoltán
