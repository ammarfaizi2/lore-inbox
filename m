Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264034AbSIQK3G>; Tue, 17 Sep 2002 06:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264035AbSIQK3G>; Tue, 17 Sep 2002 06:29:06 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:54028 "EHLO
	mail2.cybertrails.com") by vger.kernel.org with ESMTP
	id <S264034AbSIQK3F>; Tue, 17 Sep 2002 06:29:05 -0400
Date: Tue, 17 Sep 2002 03:33:26 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org, Srinivas Chavva <chavvasrini@yahoo.com>
Subject: Re: Configuring kernel
Message-Id: <20020917033326.0daaa62e.dickson@permanentmail.com>
In-Reply-To: <20020915223408.51335.qmail@web13201.mail.yahoo.com>
References: <3D83A943.3010200@davehollis.com>
	<20020915223408.51335.qmail@web13201.mail.yahoo.com>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002 15:34:08 -0700 (PDT), Srinivas Chavva wrote:

> When I tried to execute the command "make xconfig" I
> got the following output
> 
> rm -f include/asm
> (cd include; ln -sf asm -i386 asm)
> make -C scripts knconfig.tk
> make: *** scripts: No such file or directory. Stop.
> make: *** [xconfig] Error 2

I get:

  rm -f include/asm
  ( cd include ; ln -sf asm-i386 asm)
  make -C scripts kconfig.tk
  make[1]: Entering directory `/usr/src/linux-2.4.18/scripts'
  <...>

Did you unpack the kernel as root and now trying to configure the kernel
as a normal user?  The error is stating the equivelent that the directory
`/usr/src/linux-2.4.18/scripts' is not there (make was trying to cd into
it).  So I assume you either deleted the directory or you don't have
access to it.

	-Paul

