Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUGETeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUGETeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUGETeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:34:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:63686 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261232AbUGETeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:34:18 -0400
Date: Mon, 5 Jul 2004 12:32:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6 and usb deadlock (and synaptics)
Message-Id: <20040705123243.7527e923.akpm@osdl.org>
In-Reply-To: <20040705131002.GA14768@gamma.logic.tuwien.ac.at>
References: <20040705131002.GA14768@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> Hi Andrew!
> 
> With 2.6.7-mm6 my laptop stops working completely. Ooops while booting.
> 
> Reverting
> - usb-locking-fix.patch
> - bk-usb.patch
> makes it work.

OK.

> Yre you interested in the output of the kernel oops? I could recompile
> the `bad' kernel and copy the Oops by hand from the screen.

Yes, please.

> 
> BTW: With 2.6.7-mm6 my synaptics touchpad is not recognized anymore at
> boot time from the driver.

Please:

- Revert the USB patches
- boot, record the `dmesg -s 1000000' output
- revert bk-input.patch, see if that fixess the touchpad.
- if it does, capture the `dmesg -s 1000000' output again.

> Is this done somewhere in the usb stuff?

No.

> And X does not start because it cannot find the synaptics stuff. Have
> there been any changes in this area?

Yup, lots.


