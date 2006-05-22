Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWEVOWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWEVOWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWEVOWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:22:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55530 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750853AbWEVOW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:22:29 -0400
Subject: Re: [PATCH] Add user taint flag
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1148307276.3902.71.camel@laptopd505.fenrus.org>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
	 <1148307276.3902.71.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 15:35:48 +0100
Message-Id: <1148308548.17376.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-22 at 16:14 +0200, Arjan van de Ven wrote:
> we should then patch the /dev/mem driver or something to set this :)
> (well and possibly give it an exception for now for PCI space until the
> X people fix their stuff to use the proper sysfs stuff)

/dev/mem is used for all sorts of sane things including DMIdecode.
Tainting on it isn't terribly useful. Mind you this whole user taint
patch seems bogus as it can only be set by root owned processes so
doesn't appear to do the job it is intended for - perhaps Ted can
explain ?

What X needs btw is mmap on PCI mmio bars, teach the X mapping code to
use those instead of /dev/mem is a simple matter of coding as the right
abstractions are in the tree already.

It would need the kernel to also provide a /dev/isa mapping however.

Alan

