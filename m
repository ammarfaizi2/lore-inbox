Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLYCwW>; Sun, 24 Dec 2000 21:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLYCwN>; Sun, 24 Dec 2000 21:52:13 -0500
Received: from attila.bofh.it ([213.92.8.2]:4819 "HELO attila.bofh.it")
	by vger.kernel.org with SMTP id <S129370AbQLYCvz>;
	Sun, 24 Dec 2000 21:51:55 -0500
Date: Mon, 25 Dec 2000 00:53:03 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001225005303.A205@wonderland.linux.it>
In-Reply-To: <20001224170052.A223@wonderland.linux.it> <Pine.LNX.4.10.10012240941540.3972-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10012240941540.3972-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 24, 2000 at 09:57:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 24, Linus Torvalds <torvalds@transmeta.com> wrote:

 >	/* The page is dirty, or locked, move to inactive_dirty list. */
 >	if (page->buffers || TryLockPage(page)) {
 >		...
 >
 >and change the test to
 >
 >	if (page->buffers || PageDirty(page) || TryLockPage(page)) {
Done, no change.
Got some articles, restarted the server, all is good.
Got other articles, rebooted and the files now differ.


And I have another problem: I'm experiencing random hangs using X[1] with
2.4.0-test12. After a variable amount of time, some of the times I use X
(I mostly use console) it just freezes hard (no caps lock activity).
I'm not sure if this only happens while using X or it's just less
frequent in console. -test9 works fine and I used it since it has been
released with no ill effects.


My hardware:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8029(AS)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Productiva] AGP (rev 02)


vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 267.282
cache size      : 64 KB


gcc version 2.95.2 20000220 (Debian GNU/Linux)


[1] Good old stable XF86_SVGA 3.x from debian potato.
-- 
ciao,
Marco

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
