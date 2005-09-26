Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVIZWgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVIZWgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVIZWgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:36:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:47335 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932323AbVIZWgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:36:09 -0400
Subject: Re: 2.6.14-rc2-mm1 ide problems on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20050926190240.GA32409@mipter.zuzino.mipt.ru>
References: <1127758020.16275.19.camel@dyn9047017102.beaverton.ibm.com>
	 <20050926190240.GA32409@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 15:35:39 -0700
Message-Id: <1127774139.16275.22.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 23:02 +0400, Alexey Dobriyan wrote:

> If you have quilt(1) installed and don't mind a couple recompiles, you
> can do a bisection on -mm patches:
> 
> 1) Unpack clean 2.6.14-rc2.
> 2) Apply attached patch to it ("bisect-mm" script).
> 3) chmod 755 ./bisect-mm
> 
> 4) cp -r $WHATEVER/broken-out patches	# copy broken out -mm to the top
> 					# level directory
> 
> "Dumb" mode:
> 
> 5)	./bisect-mm start
> 6)	./bisect-mm apply
> 					# wait until patches are applied
> 					# or reverted
> 7)		rebuild
> 		reboot
> 8)	./bisect-mm good		# if it boots fine, or
> 	./bisect-mm bad
> 		goto 6
> 
> Continue until it says "Sucker is ...".
> 
> You can also enter "smart" mode after reading comment at the beginning
> of the script. It can save your some recompiles.

Well, I tried using your script to bisect -mm patches.

I did steps (1) - (7) without problem. Then my kernel didn't boot.
So I did 

	./bisect-mm bad
	./bisect-mm apply

I get following messages infinitely. Seems to be problem with
scripts/quilt. 

Anyway, I will do manual binary search.

Thanks,
Badari

Patch acx1xx-wireless-driver does not remove (enforce with -f)
Removing acx1xx-wireless-driver
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/pci_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/usb_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
Patch acx1xx-wireless-driver does not remove (enforce with -f)
Removing acx1xx-wireless-driver
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/pci_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/usb_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
Patch acx1xx-wireless-driver does not remove (enforce with -f)
Removing acx1xx-wireless-driver
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/pci_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/usb_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
Patch acx1xx-wireless-driver does not remove (enforce with -f)
Removing acx1xx-wireless-driver
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/pci_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/usb_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
Patch acx1xx-wireless-driver does not remove (enforce with -f)
Removing acx1xx-wireless-driver
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/pci_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/usb_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
Patch acx1xx-wireless-driver does not remove (enforce with -f)
Removing acx1xx-wireless-driver
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/pci_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/usb_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
Patch acx1xx-wireless-driver does not remove (enforce with -f)
Removing acx1xx-wireless-driver
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/pci_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/usb_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
Patch acx1xx-wireless-driver does not remove (enforce with -f)
Removing acx1xx-wireless-driver
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/pci_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored
The next patch, when reversed, would delete the file
drivers/net/wireless/tiacx/usb_helper.c,
which does not exist!  Ignore -R? [n]
Apply anyway? [n]
....

