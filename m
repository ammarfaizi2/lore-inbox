Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUDIMTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 08:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUDIMTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 08:19:24 -0400
Received: from village.ehouse.ru ([193.111.92.18]:25350 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261231AbUDIMTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 08:19:22 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.X kernel memory leak?
Date: Fri, 9 Apr 2004 16:15:04 +0400
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, anton@megashop.ru
References: <200401311940.28078.rathamahata@php4.ru> <200404091117.01011.rathamahata@php4.ru> <20040409020903.0897857d.akpm@osdl.org>
In-Reply-To: <20040409020903.0897857d.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404091615.04340.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Friday 09 April 2004 13:09, Andrew Morton wrote:
> "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> >
> > And here is part of sysrq-T for the third machine, which have just locked up,
> >  kernel is 2.6.5-rc3-aa2.
> 
> It does look like a kernel memory leak, but it's not into slab.
> 
> You've disabled iptables.  Possibly there's a leak in a device driver? 
> Which drivers are in regular use there?  What are you using for those
> hardware RAID controllers?

I've seen this kind of lockup (according to sysrq-T) on different boxes:

1) ope
	RAID:		mylex 352
	drivers:	e100, dac960
	.config:	http://sysadminday.org.ru/2.6.1-io_lockup/ope/.config

2) terror
	RAID:		megaraid 320-2
	drivers:	e1000, megaraid2
	.config:	http://sysadminday.org.ru/2.6.X-lockup/terror/.config

3) mirror
	drivers:	e100, aic7xxx, md, netconsole
	.config:	http://sysadminday.org.ru/2.6.X-lockup/mirror/.config

I also saw the same symptoms on a fourth box, but I'm not shure about
this one because it didn't use to be attached to serial console at that time.

For this box:
	RAID:		Compaq smart 2
	drivers:	tlan,epic100,cpqarray

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
