Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932893AbWF2Lmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893AbWF2Lmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932891AbWF2Lmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:42:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64933 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932893AbWF2Lmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:42:44 -0400
Subject: Re: make PROT_WRITE imply PROT_READ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Ulrich Drepper <drepper@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Jason Baron <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060629073033.GF27526@elf.ucw.cz>
References: <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
	 <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
	 <20060628194913.GA18039@elf.ucw.cz>
	 <a36005b50606281647i58f2899eo7ae7e95757969d42@mail.gmail.com>
	 <20060629073033.GF27526@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jun 2006 12:58:42 +0100
Message-Id: <1151582323.23785.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-29 am 09:30 +0200, ysgrifennodd Pavel Machek:
> > PROT_READ to be used or implicitly adding it.  Don't confuse people
> > with wrong statement like yours.
> 
> Can you quote part of POSIX where it says that PROT_WRITE must imply
> PROT_READ?

I don't believe POSIX cares either way

"An implementation may permit accesses other than those specified by
prot; however, if the Memory Protection option is supported, the
implementation shall not permit a write to succeed where PROT_WRITE has
not been set or shall not permit any access where PROT_NONE alone has
been set."

However the current behaviour of "write to map read might work some days
depending on the execution order of instructions" (and in some cases the
order that the specific CPU does its tests for access rights) is not
sane, not conducive to application stability and not good practice.

Alan

