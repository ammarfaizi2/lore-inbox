Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbQKOXyR>; Wed, 15 Nov 2000 18:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbQKOXyG>; Wed, 15 Nov 2000 18:54:06 -0500
Received: from dillweed.dsl.xmission.com ([166.70.14.212]:8796 "HELO
	winder.codepoet.org") by vger.kernel.org with SMTP
	id <S129165AbQKOXx4>; Wed, 15 Nov 2000 18:53:56 -0500
Date: Wed, 15 Nov 2000 16:30:12 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
Message-ID: <20001115163012.B13732@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001114011331.B1496@codepoet.org> <m1bsvia9bt.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1bsvia9bt.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Tue, Nov 14, 2000 at 07:59:18AM -0700
X-Operating-System: Linux 2.2.17, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 14, 2000 at 07:59:18AM -0700, Eric W. Biederman wrote:
> 
> All mkelfImage does is the pasting of initrd's, command lines,
> and just a touch of argument conversion code.

You can link in an initrd using linker magic, i.e.
    $(OBJCOPY) --add-section=image=kernel --add-section=initrd=initrd.gz

This is done in ppc/boot/Makefile for example.  It might be a nice thing
to add a .config option to optionally specify an initrd to link into
the kernel image.  Similarly, several architectures have a CONFIG_CMDLINE
which could also do the job (see arch/ppc/config.in for example).  

Presumably, by doing such things you could avoid needing to use mkelfImage.

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org
--This message was written using 73% post-consumer electrons--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
