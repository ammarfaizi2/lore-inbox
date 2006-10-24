Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWJXOD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWJXOD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWJXOD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:03:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63202 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161002AbWJXOD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:03:57 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Giridhar Pemmasani <pgiri@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061024024347.57840.qmail@web32414.mail.mud.yahoo.com>
References: <20061024024347.57840.qmail@web32414.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Oct 2006 15:07:10 +0100
Message-Id: <1161698830.22348.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-23 am 19:43 -0700, ysgrifennodd Giridhar Pemmasani:
> I was not fully aware of this issue until now (I have read posts related to
> this issue now). Does this mean that any module that loads binary code can't
> be GPL, even those that load firmware files? How is

Firmware is usually more clearly separated (the problem ultimately is
that "derived work" is a legal not a technical distinction).

> non-GPL-due-to-transitivity going to be checked? Why does module loader mark
> only couple of modules as non-GPL, when there are other drivers that load
> some sort of binary code? It is understandable to mark a module as non-GPL if
> it is lying about its license, but as far as that is concerned, ndiswrapper
> (alone) is GPL.

Yes. I don't think the current situation is neccessarily correct, but if
it uses EXPORT_SYMBOL_GPL then the "now taint me" ought to fail and the
driver ought to refuse to load a non GPL windows driver.

Alan

