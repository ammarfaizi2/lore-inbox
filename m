Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131437AbQKTJyB>; Mon, 20 Nov 2000 04:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131548AbQKTJxv>; Mon, 20 Nov 2000 04:53:51 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:20041 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131437AbQKTJxl>; Mon, 20 Nov 2000 04:53:41 -0500
Date: Mon, 20 Nov 2000 09:23:39 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre7: isapnp hang
Message-ID: <20001120092339.I20970@redhat.com>
In-Reply-To: <E13xeWC-0003AP-00@the-village.bc.nu> <E13xegT-0003An-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13xegT-0003An-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 20, 2000 at 12:19:43AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 12:19:43AM +0000, Alan Cox wrote:

> And a quick read of the code I pasted instead of just pasting
> suggests instead we should be using the patch below. Question
> however is who stole port 0x279 which is the normal port to use. It
> shouldnt be lp since lp is supposed to init after pnp.

Your patch fixes the problem (of course).  lp is not compiled into the
kernel (nor is parport), and after boot /proc/ioports shows:

[...]
01f0-01f7 : ide0
02e8-02ef : serial(auto)
[...]

Tim.
*/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
