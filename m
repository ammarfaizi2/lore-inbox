Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbRJTHMQ>; Sat, 20 Oct 2001 03:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274809AbRJTHMG>; Sat, 20 Oct 2001 03:12:06 -0400
Received: from pcow028o.blueyonder.co.uk ([195.188.53.124]:2825 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S274544AbRJTHLy>;
	Sat, 20 Oct 2001 03:11:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol hotplug_path in usbcore.o as a module (2.4.12)
Date: Sat, 20 Oct 2001 08:12:14 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <28682.1003560517@ocs3.intra.ocs.com.au>
In-Reply-To: <28682.1003560517@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15uqJ1-0008Mq-01@roo.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 20 October 2001 7:48 am, Keith Owens wrote:
> On Fri, 19 Oct 2001 20:21:17 +0100,
>
> Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> >I have built the the 2.4.12 kernel with CONFIG_HOTPLUG set and the usb
> > stuff all compiled as modules.
> >
> >depmod -e  shows that usbcore.o has an unresolved symbol (which of course
> >fails when the module tries to load) of hot_plug path.
>
> I need the output from
>   nm -A `/sbin/modprobe -l`  | grep hotplug_path

alan@kanger:~$ nm -A `/sbin/modprobe -l` | grep hotplug_path
/lib/modules/2.4.12/kernel/drivers/usb/usbcore.o:         U hotplug_path
alan@kanger:~$

>   grep hotplug_path /proc/ksyms System.map


alan@kanger:/$ grep hotplug_path /proc/ksyms System.map
/proc/ksyms:c0290960 hotplug_path_R__ver_hotplug_path
System.map:c02810a0 ? __kstrtab_hotplug_path
System.map:c028bb98 ? __ksymtab_hotplug_path
System.map:c0290960 D hotplug_path
alan@kanger:/$
- -- 

  Alan - alan@chandlerfamily.org.uk
http://www.chandlerfamily.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE70SPa1mf3M5ZDr2kRAkb6AJ0eyEL3EDiCdrrZdNGeT5utXP+rRwCgzaDY
MkVDEVYXdsfCWrin8w30w0M=
=qjMd
-----END PGP SIGNATURE-----
