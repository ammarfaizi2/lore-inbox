Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSECP5i>; Fri, 3 May 2002 11:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314486AbSECP5h>; Fri, 3 May 2002 11:57:37 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:32013 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314485AbSECP5g>;
	Fri, 3 May 2002 11:57:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: tomas szepe <kala@pinerecords.com>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 release 2.4
In-Reply-To: Your message of "Fri, 03 May 2002 17:45:54 +0200."
             <20020503154554.GB15883@louise.pinerecords.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 May 2002 01:57:26 +1000
Message-ID: <15755.1020441446@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002 17:45:54 +0200, 
tomas szepe <kala@pinerecords.com> wrote:
>$ make -f Makefile-2.5 menuconfig
>[enable RAMDISK support, tweak ramdisk size, enable initrd]
>...
>
>Now, issuing "M installable" will result in nearly all files getting rebuilt.
>The same happens when switching ramdisk off again. How's that?
>
>I tried enabling/disabling many other config options and doing rebuilds but
>couldn't find anything as damaging buildtime-wise as the ramdisk stuff.

CONFIG_BLK_DEV_INITRD is tested in include/linux/fs.h.  Because of the
messy kernel include files, a config change to fs.h affects hundreds of
other files and forces lots of rebuilds.  This is a separate problem
from kbuild, other people are looking at cleaning up the include files.

