Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUISRQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUISRQI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUISRQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:16:07 -0400
Received: from [81.23.229.73] ([81.23.229.73]:8428 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S264386AbUISRNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:13:09 -0400
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: plt@taylorassociate.com
Subject: Re: Kernel build error in make modules_install
Date: Sun, 19 Sep 2004 19:12:53 +0200
User-Agent: KMail/1.6.2
References: <1095596968.414d7ba88efc1@webmail.taylorassociate.com> <200409191831.12034.Norbert@edusupport.nl> <1095612208.414db730c4fc0@webmail.taylorassociate.com>
In-Reply-To: <1095612208.414db730c4fc0@webmail.taylorassociate.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409191912.53574.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added a bigger title than just "Re:" Probably that gives slightly more help 
(-:
No, sometimes the directory is not there, which of course gives problems.

What is the version (Probably best recognizable by looking at the file date 
compared to you last build) of System.map in / or /boot? Does it exist?

Another small hint:
make bzImage is not needed anymore. You are doing making the image twice (Ok, 
the second time it skips everything, but still).

For more information about the error you run into, you can get more 
information by turning on verbosity (make V=1)
After the make modules_install you still have to do a make install

On Sunday 19 September 2004 18:43, you wrote:
> Sorry, I do understand the question your asking.  The directory does exist
> on the hard drive.  What file would I look in to to see if the present for
> modules to install in please?
>
> I typed the following commands to install the new kernel.
>
> 1. make mrproper
> 2. make menuconfig
> 3. make bzImage
> 4. make && make modules_install
>
> I did this from the /mnt/hda2/users/frodo/linux-2.6.8 and the system is
> installed on the /hda1 directory.
>
> [root@localhost logs]# ls -l /mnt/hda2/users/frodo/linux-2.6.8
> total 42864
> drwxrwxr-x  23  500  500     4096 Aug 14 01:36 arch
> -rw-r--r--   1  500  500    18691 Aug 14 01:36 COPYING
> -rw-r--r--   1  500  500    86490 Aug 14 01:37 CREDITS
> drwxrwxr-x   2  500  500     4096 Sep 19 10:17 crypto
> drwxrwxr-x  43  500  500     4096 Aug 14 01:38 Documentation
> drwxrwxr-x  45  500  500     4096 Sep 19 02:16 drivers
> drwxrwxr-x  52  500  500     4096 Sep 19 10:38 fs
> drwxrwxr-x  36  500  500     4096 Sep 19 01:26 include
> drwxrwxr-x   2  500  500     4096 Sep 19 02:34 init
> drwxrwxr-x   2  500  500     4096 Sep 19 01:48 ipc
> drwxrwxr-x   3  500  500     4096 Sep 19 01:36 kernel
> drwxrwxr-x   4  500  500     4096 Sep 19 10:39 lib
> -rw-r--r--   1  500  500    52962 Aug 14 01:37 MAINTAINERS
> -rw-r--r--   1  500  500    37961 Aug 14 01:37 Makefile
> drwxrwxr-x   2  500  500     4096 Sep 19 01:39 mm
> -rw-r--r--   1 root root   184320 Sep 19 10:16 Module.symvers
> drwxrwxr-x  32  500  500     4096 Sep 19 02:33 net
> -rw-r--r--   1  500  500    13970 Aug 14 01:37 README
> -rw-r--r--   1  500  500     2815 Aug 14 01:36 REPORTING-BUGS
> drwxrwxr-x   9  500  500     4096 Sep 19 01:27 scripts
> drwxrwxr-x   3  500  500     4096 Sep 19 01:50 security
> drwxrwxr-x  15  500  500     4096 Sep 19 10:48 sound
> -rw-r--r--   1 root root   589313 Sep 19 02:43 System.map
> drwxrwxr-x   2  500  500     4096 Sep 19 01:28 usr
> -rwxr-xr-x   1 root root 42759678 Sep 19 02:43 vmlinux
> [root@localhost logs]#
>
>
> Thank you
> Phillip Taylor
>
> Quoting Norbert van Nobelen <Norbert@edusupport.nl>:
> > Assumption:
> > You are doing "make modules_install"
> > You are installing a new version of the kernel, not a recompile of the
> > currenct kernel.
> >
> > Is the basic directory in /lib/modules/2.6.8 present for the modules to
> > install in?
> >
> > On Sunday 19 September 2004 17:32, you wrote:
> > > I am compiling the newest kernel on Redhat Federo 2 and and I am
> > > getting this error when I am running make modules install.  Do you know
> > > how I fix this problems please?
> > >
> > > Phillip Taylor
> > >
> > > INSTALL sound/pci/ymfpci/snd-ymfpci.ko
> > >   INSTALL sound/pcmcia/pdaudiocf/snd-pdaudiocf.ko
> > >   INSTALL sound/soundcore.ko
> > >   INSTALL sound/synth/emux/snd-emux-synth.ko
> > >   INSTALL sound/synth/snd-util-mem.ko
> > >   INSTALL sound/usb/snd-usb-audio.ko
> > > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.8; fi
> > > make: *** [_modinst_post] Error 143
> > > You have new mail in /var/spool/mail/root
> > > [root@localhost linux-2.6.8]#
> > >
> > > Quoting Norbert van Nobelen <Norbert@edusupport.nl>:
> > > > Warnings are not errors.
> > > >
> > > > On Sunday 19 September 2004 14:29, you wrote:
> > > > > Question: Are you guys going to work on please cleaning up some of
> > > > > the errors in the code so we can get please get a more clean
> > > > > compile?
> > > > >
> > > > >
> > > > >
> > > > > drivers/mtd/nftlmount.c:44: warning: unused variable `oob'
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > This message was sent using IMP, the Internet Messaging Program.
> > > > >
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe
> >
> > linux-kernel"
> >
> > > > > in the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > > ----------------------------------------------------------------
> > > This message was sent using IMP, the Internet Messaging Program.
>
> ----------------------------------------------------------------
> This message was sent using IMP, the Internet Messaging Program.
