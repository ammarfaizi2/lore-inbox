Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAOJTk>; Mon, 15 Jan 2001 04:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbRAOJT3>; Mon, 15 Jan 2001 04:19:29 -0500
Received: from smithers.2z.net ([206.98.112.25]:56837 "EHLO smithers.2z.net")
	by vger.kernel.org with ESMTP id <S129737AbRAOJTT>;
	Mon, 15 Jan 2001 04:19:19 -0500
Message-ID: <3A62C038.803225DA@elven.org>
Date: Mon, 15 Jan 2001 03:17:44 -0600
From: fool@elven.org
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.0: couple typos in 'make menuconfig', also kbd freeze 
 workaround, stuck swapping, etc
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, I couldn't build an Athlon version of the kernel either, actually
for my Duron (btw, Duron should get listed in the processor config).
Build errors
("__memcpy3d" etc) were the same as the other posting I saw.

Other config issue: when I drop a .config in a clean kernel tree, I need
to do a 'make menuconfig' even though I don't make any changes in it, or
the subsequent
'make dep' fails. Maybe this is well-known, but it struck me as odd.

My 700Mhz Duron w/128M ram stalled thrashing once. After 20 mins, I did
a ctl-alt-del and it was still swapping so much that the Redhat7 init
script reported
failures for shutting some services down. Something like "VM swap page
bad somenumber" was printed a few times. I've heard the ac patches may
fix the swapping
issue.

In "make menuconfig": when you enable the first option here, the
additional option pops out in the wrong place:
  [*]     Generic PCI bus-master DMA support
  [ ]     Boot off-board chipsets first support
    [ ]       Use PCI DMA by default when available

Also the CONFIG_IDEDMA_IVB help info mispells "valid".

I was hitting the keyboard lockup when trying the Redhat7 Xconfigurator
program (I have a PS/2 mouse). Using xf86config instead worked fine. No
problems with
"gpm -t ps/2" either.

On a side note, back in the test-series kernel, I reported filesystem
corruption on my VIA IDE w/DMA on. I was surprised to find out that the
filesystem was only all messed up when mounting with an 2.2 system.
Using the newer kernel, none of the corruption was visible, and I was
able to recover everything.
Hopefully, my hard drive will live happily ever after.

Some filesystem questions: Is it possible for corruption to persist
after a mkfs over the old partition (and what if the mkfs is older than
the mkfs originally used to make the partition?). I was sure that at one
point, a directory from the old wiped out partition popped up after the
mkfs and an install of a distro. Also can a corrupted filesystem taint a
clean filesystem just through cp (again considering different versions
of the tools)? If you corrupt a hard drive, do you need to rewrite the
partition table if it "looks" ok? Is read-only mounting proof against
corruption?


Saber Taylor
http://elven.org/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
