Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313332AbSDGOxw>; Sun, 7 Apr 2002 10:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313347AbSDGOxv>; Sun, 7 Apr 2002 10:53:51 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:29965 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313332AbSDGOxu>;
	Sun, 7 Apr 2002 10:53:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Sun, 07 Apr 2002 16:51:36 +0200."
             <3CB05CF8.4513BA83@linux-m68k.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 00:53:36 +1000
Message-ID: <28835.1018191216@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Apr 2002 16:51:36 +0200, 
Roman Zippel <zippel@linux-m68k.org> wrote:
>Keith Owens wrote:
>> make NO_MAKEFILE_GEN=1 foo/bar.o.  Very low overhead for quick and
>> dirty testing of changes, but if you want an accurate kernel build, you
>> have to take the overhead.  kbuild 2.4 overhead for a full build when
>> only minor changes have been made is even worse.
>
>I don't want a kernel build, I just want a single object file to be
>rebuilt?!
>I can understand that it takes longer, when I change a Makefile or the
>config, but why has the Makefile to be rebuilt, when only a source file
>changed?

It takes time to do all the analysis to work out what has changed and
what has been affected.  You might know that you only changed one file
but kernel build and make don't know that until they have checked
everything.  Changing one file or specifying a command override might
affect one file or it might affect the entire kernel.

If you know that you have only changed one source file and you have not
altered the Makefiles or the dependency chain in any way, then it
_might_ be safe to just rebuild that one file, use NO_MAKEFILE_GEN=1.
Otherwise let kbuild work out what has been affected.

