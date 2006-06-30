Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWF3MEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWF3MEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWF3MEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:04:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39823 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932170AbWF3MEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:04:45 -0400
Subject: Re: make PROT_WRITE imply PROT_READ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ulrich Drepper <drepper@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Jason Baron <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1151656545.11434.8.camel@laptopd505.fenrus.org>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
	 <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
	 <1151568930.3122.0.camel@laptopd505.fenrus.org>
	 <a36005b50606292048y2436282cv909a264b4fb7b909@mail.gmail.com>
	 <1151656545.11434.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 13:20:59 +0100
Message-Id: <1151670059.31392.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 10:35 +0200, ysgrifennodd Arjan van de Ven:
> apps like JVM's forgot PROT_EXEC and break when the hardware enforces it
> apps that forget PROT_READ break when the kernel/hardware enforce it
> 
> not too much difference....

There is quite a difference. The _EXEC case behaves predictably for the
platforms that support it. At least I am not aware of cases that is not
true. The _READ case without the fault handling patch behaves
unpredictably depending on the precise ordering of events on a clean
page. 

Alan

