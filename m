Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQJaCH7>; Mon, 30 Oct 2000 21:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129804AbQJaCHt>; Mon, 30 Oct 2000 21:07:49 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:59664 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129121AbQJaCHp>;
	Mon, 30 Oct 2000 21:07:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Christoph Hellwig <hch@ns.caldera.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Tue, 31 Oct 2000 12:49:12 +1100."
             <13675.972956952@ocs3.ocs-net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 13:07:38 +1100
Message-ID: <13976.972958058@ocs3.ocs-net>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000 12:49:12 +1100, 
Keith Owens <kaos@ocs.com.au> wrote:
>You will compile all export objects, whether they are configured or
>not.  The "obvious" fix does not work.
>
>	MIX_OBJS        := $(filter $(export-objs),$(obj-y) $(obj-m))
>
>export_objs contains usb.o, obj-y contains usb_core.o, it does not
>contain usb.o.  Multi lists in obj-y and obj-m need to be expanded
>while preserving the required link order.

Correction to my own mail.  Multi lists in obj-y and obj-m just need to
be expanded, the order does not matter in MIX_OBJS.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
