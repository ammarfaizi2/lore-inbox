Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285117AbRLRUhy>; Tue, 18 Dec 2001 15:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285126AbRLRUhs>; Tue, 18 Dec 2001 15:37:48 -0500
Received: from mail.myrio.com ([63.109.146.2]:34041 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S285132AbRLRUgd>;
	Tue, 18 Dec 2001 15:36:33 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB0A@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Grover, Andrew'" <andrew.grover@intel.com>,
        "'Alexander Viro'" <viro@math.psu.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: RE: Booting a modular kernel through a multiple streams file
Date: Tue, 18 Dec 2001 12:35:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

[...]

> I'm arguing that no matter 
> how whizzy
> initrd is, it's still an unnecessary step, and it's one that 
> other OSs (e.g.
> FreeBSD) omit in favor of the approach I'm advocating.

Well, I'm a linux user more than a developer but I disagree.

It isn't hard to make an initrd, and initrd will always be 
neccessary for some things.  Since we can't get rid of it 
and don't want to (*), I like the approach of making it better.

* I network boot (via pxelinux boot loader) a linux kernel and 
initrd.gz, total size <2 MB, which then proceeds to:

1 - load network drivers, do dhcp
2 - partition and format the hard disk
3 - mount the new filesystems
4 - download (with retry/resume), unpack, cryptographically 
    verify, and install a complete (~100 mb) embedded linux
    system.  
5 - while it does all the above, it shows pretty graphics and
    "please wait while we setup your system" messages on the
    attached television set via framebuffer support.

You may be able to get grub to do the first step but the next
four would be... challenging.  I agree that grub is cool, though.

Torrey Hoffman
