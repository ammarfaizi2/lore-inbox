Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315569AbSECGcz>; Fri, 3 May 2002 02:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315570AbSECGcy>; Fri, 3 May 2002 02:32:54 -0400
Received: from air-2.osdl.org ([65.201.151.6]:47884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315569AbSECGcy>;
	Fri, 3 May 2002 02:32:54 -0400
Date: Thu, 2 May 2002 23:32:47 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: <7691.1020402149@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33L2.0205022238410.11832-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Keith Owens wrote:

| On Thu, 2 May 2002 21:17:43 -0700 (PDT),
| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >I kinda like to do 'make bzImage' without making modules also.
| >Would that be difficult to do in kbuild 2.5?
| >Oh, but then I would also (still) need 'make modules'...
|
| Sample testing targets, to see if you made any typing errors.
|
|   make vmlinux
|   make arch/i386/boot/bzImage
|   make drivers/acpi (non-recursive)
|   make drivers/acpi-r (recursive)

      make -f Makefile-2.5 <target>

      Yes, that works fine.

      So if my .config file has lots of USB modules =m,
      I can just make drivers/usb-r and it will make all
      of the specified modules ?
      Yes, I did that.

| Do it with NO_MAKEFILE_GEN=1 for much, much! faster builds.  But you
| should really do a clean make installable (which will do modules as
| well) before make install.
|
| >Any ideas about this error?  user error??
| >
| >$ make oldconfig menuconfig
| >
| >... and then
| >
...
| >make: *** [/usr/linsrc/linux-2513-pv/.config] Error 1
|
| You mixed the old kbuild 2.4 make *config with a kbuild 2.5 build.
| Don't do that.

DDT.  Got it.  Thanks.

| One of the downsides of coexistence, users can get it wrong.

Right.

| make -f Makefile-2.5 menuconfig installable

Working now.  I appreciate your help and kbuild 2.5.

-- 
~Randy

