Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129200AbQKFRXo>; Mon, 6 Nov 2000 12:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQKFRXe>; Mon, 6 Nov 2000 12:23:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45908 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129388AbQKFRX3>; Mon, 6 Nov 2000 12:23:29 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: vonbrand@inf.utfsm.cl (Horst von Brand)
Date: Mon, 6 Nov 2000 17:23:11 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), linux-kernel@vger.kernel.org
In-Reply-To: <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl> from "Horst von Brand" at Nov 06, 2000 01:31:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13spzE-0006Q3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No funny "persistent data" mechanisms or screwups when the worker gets
> removed and reinserted. In many cases the data module could be shared among
> several others, in other cases it would have to be able lo load several
> times or manage several incarnations of its payload.

It actually seems the persistent data mechanism in user space wouldnt be
much different in implementation.

Add a 'preserved' tag for one section of module memory. On load look up the
data, if its from this boot memcpy it into the module. On unload write it
back to disk. No kernel code needed.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
