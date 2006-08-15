Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWHOSr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWHOSr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWHOSr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:47:26 -0400
Received: from mail.windriver.com ([147.11.1.11]:58512 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S965114AbWHOSrZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:47:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Unable to boot kernel after compiling source for 2.6.17-1.2157
Date: Tue, 15 Aug 2006 11:46:59 -0700
Message-ID: <238E9E8D08550342B3642CB0631EFFD42F8EEB@ala-mail04.corp.ad.wrs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to boot kernel after compiling source for 2.6.17-1.2157
Thread-Index: AcbAgFNLWe68NHNMQqS13Z8rYiwI5wAGqz2g
From: "Zeidler, Mike" <mike.zeidler@windriver.com>
To: "Arjan van de Ven" <arjan@infradead.org>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, doing the "make install" as root did the trick. Machine boots
like a charm.

Mike 

-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Tuesday, August 15, 2006 11:34 AM
To: Michal Piotrowski
Cc: Zeidler, Mike; linux-kernel@vger.kernel.org
Subject: Re: Unable to boot kernel after compiling source for
2.6.17-1.2157

On Tue, 2006-08-15 at 17:31 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 15/08/06, Zeidler, Mike <mike.zeidler@windriver.com> wrote:
> > After building the kernel  and copying the arch/i386/boot/bzImage to

> > /boot/vmlinuz-2.6.17-1.2157_FC5smp
> > and doing a make modules_install
> > and doing a mkinitrd


it's even easier: just do a "make install" 

it looks like the original bug is an selinux case (since nothing else
should prevent modules from loading ;).. could be a bad initrd could be
something else.



