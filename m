Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282258AbRKWWM4>; Fri, 23 Nov 2001 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282260AbRKWWMr>; Fri, 23 Nov 2001 17:12:47 -0500
Received: from ns01.netrox.net ([64.118.231.130]:37354 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S282258AbRKWWMh>;
	Fri, 23 Nov 2001 17:12:37 -0500
Subject: Re: Kernel Compilation Basics
From: Robert Love <rml@tech9.net>
To: "Paulo J. Matos aka  " PDestroy <pocm@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3pu69qheo.fsf@localhost.localdomain>
In-Reply-To: <m3pu69qheo.fsf@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 23 Nov 2001 17:11:21 -0500
Message-Id: <1006553483.1351.3.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-23 at 16:57, Paulo J. Matos aka PDestroy wrote:
> I'm trying to compile 2.4.15.
> I've read Kernel Howto and I've done the quick compilation steps:
> make xconfig
> make dep
> make clean
> make bzImage
> cp arch/i386/boot/bzImage /boot/vmlinuz-2.4.15
> make modules
> make modules_install
> 
> What about now?
> How do I create system map and modules info?
> What are they for?
> I feel that kernel howto is not explicit with this questions.
> Is there any place where can I get insight about these questions?

You already have a System.map, it is in the root of your linux source
directory.  Thus, as you copied vmlinuz over, do the same for
System.map:

	cp System.map /boot/System.map-2.4.15

modules-info is something specific to RedHat which you do not need. 
`make modules_install' is all that is required.  Now, edit your
bootloader (lilo, grub, etc) and reboot.  Enjoy.

	Robert Love

