Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSDFPvB>; Sat, 6 Apr 2002 10:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293306AbSDFPvA>; Sat, 6 Apr 2002 10:51:00 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:63752 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293135AbSDFPu7>;
	Sat, 6 Apr 2002 10:50:59 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: make install bug? 
In-Reply-To: Your message of "Sat, 06 Apr 2002 16:15:31 +0100."
             <20020406151531.GK17144@vnl.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Apr 2002 01:50:47 +1000
Message-ID: <18560.1018108247@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Apr 2002 16:15:31 +0100, 
Dale Amon <amon@vnl.com> wrote:
>make[1]: Leaving directory `/VNetLinux/linux-2.4.18/arch/i386/lib'
>I'm not sure why this started happening, but it isn't nice
>behavior at all. I'd call it a bug as I can't imagine why
>I'd want a depmod to occur on the build machine.

depmod runs at build time as a courtesy, to build the modules.dep for
the initial boot, otherwise you get warning messages on the first boot
of a new kernel.  For cross compiling or building for a different
machine, you can turn depmod into a no-op with make DEPMOD=/bin/true.

