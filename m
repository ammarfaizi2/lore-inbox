Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129048AbQJ3NlX>; Mon, 30 Oct 2000 08:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129062AbQJ3NlN>; Mon, 30 Oct 2000 08:41:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22594 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129048AbQJ3NlE>; Mon, 30 Oct 2000 08:41:04 -0500
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 30 Oct 2000 13:41:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux_developer@hotmail.com (Linux Kernel Developer),
        linux-kernel@vger.kernel.org
In-Reply-To: <4119.972912029@ocs3.ocs-net> from "Keith Owens" at Oct 31, 2000 12:20:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qFC1-0006t5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >You may find that creating your own wrappers for these files that do
> >
> >extern "C" {
> >#define new new_
> >#define private private_
> >#include <linux/foo.h>
> >#undef new
> >#undef private
> >}
> >
> >safer, since you won't break anything
> 
> It breaks module symbol versions, see earlier mail to l-k.

I don't believe that is the case.

You compute the modversions against the C header files. You include the C++
header files in a C++ module and you include the module version file directly.
Your symbols match providing you don't have an object called private or new
that is globally exported. We don't seem to have any of those

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
