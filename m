Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQJ3NDI>; Mon, 30 Oct 2000 08:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129050AbQJ3NC6>; Mon, 30 Oct 2000 08:02:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6722 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129044AbQJ3NCu>; Mon, 30 Oct 2000 08:02:50 -0500
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17
To: linux_developer@hotmail.com (Linux Kernel Developer)
Date: Mon, 30 Oct 2000 13:04:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OE58erOc0Ne0PaLI9mK000004a6@hotmail.com> from "Linux Kernel Developer" at Oct 30, 2000 06:09:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qEbg-0006rE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> js_dev::new.  My questions are basically this.  If I update these data
> structure members' names along with the references to them in various C
> files in the kernel will all be happy in Linuxland.  Can any external

That may well be a problem. Also the use of private.

> utilities be broken or anything like that.  Or more precisely are there any
> known external utilities that would be broken by this change?  Thanks to all
> those whom can give me a hand in this.

You may find that creating your own wrappers for these files that do

extern "C" {
#define new new_
#define private private_
#include <linux/foo.h>
#undef new
#undef private
}

safer, since you won't break anything

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
