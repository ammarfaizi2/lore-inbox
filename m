Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312612AbSDOMbL>; Mon, 15 Apr 2002 08:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSDOMbK>; Mon, 15 Apr 2002 08:31:10 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:33542 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312612AbSDOMbJ>; Mon, 15 Apr 2002 08:31:09 -0400
Date: Mon, 15 Apr 2002 14:31:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Jens Axboe <axboe@suse.de>
cc: "Ivan G." <ivangurdiev@yahoo.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
In-Reply-To: <20020415120927.GO12608@suse.de>
Message-ID: <Pine.LNX.4.21.0204151419570.26902-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Apr 2002, Jens Axboe wrote:

> > These functions are only specified for PCI/ISA and there was no need so
> 
> In my mind these are generic functions, it's a shame that they come with
> a pci_ prefix and take a pci dev as first argument (the NULL for isa
> seems like a kludge).

That first argument is my problem, otherwise we could just define an alias
for them, which could be used in generic code. The current rule is to pass
NULL for non-PCI devices, but e.g. Amigas have a Zorro II and a Zorro III
bus, which have to be handled differently. Amiga drivers know how to deal
with this, but they can't use this API.

bye, Roman

