Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132970AbRDEUcp>; Thu, 5 Apr 2001 16:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132974AbRDEUch>; Thu, 5 Apr 2001 16:32:37 -0400
Received: from unimur.um.es ([155.54.1.1]:40358 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S132970AbRDEUcR>;
	Thu, 5 Apr 2001 16:32:17 -0400
Message-ID: <3ACCDB0C.3A3ED66C@ditec.um.es>
Date: Thu, 05 Apr 2001 22:52:28 +0200
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.76 [es] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED]Re: 2.2.19 && ppa: total lockup. No problem with 2.2.17
In-Reply-To: <20010330152921.Q10553@redhat.com> <Pine.LNX.4.21.0103310156530.23634-100000@ditec.um.es> <20010403173839.I9355@redhat.com> <3ACA55D5.FC2E444C@ditec.um.es> <20010404092610.P9355@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------B3D5877D3221D1B8EF552B5E"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Este es un mensaje multipartes en formato MIME.
--------------B3D5877D3221D1B8EF552B5E
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Tim Waugh escribió:
> 
> On Wed, Apr 04, 2001 at 12:59:33AM +0200, Juan wrote:
> 
> > I have the same problem in two different machines but they both are UP.
> > However, my kernel configuration has SMP support enabled.
> 
> Could you build a kernel without SMP support and see if the problem
> still happens?
Without SMP support, the machine doesn't hang but I can't load the ppa
module.
See messages below.

> 
> > options parport_pc io=0x378 irq=7
> 
> You could remove this line, just to see if it makes a difference (it
> shouldn't, but it might).
I will try this tomorrow.

> 
> > I stop klogd and syslogd services (that causes to display all kernel
> > messages on screen, doesn't it?
> 
> Better is something like 'dmesg -n 8'.
OK.

-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
--------------B3D5877D3221D1B8EF552B5E
Content-Type: text/plain; charset=us-ascii;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

[root@localhost /root]# modprobe ppa
ppa: Version 2.07 (for Linux 2.2.x)
WARNING - no ppa compatible devices found.
  As of 31/Aug/1998 Iomega started shipping parallel
  port ZIP drives with a different interface which is
  supported by the imm (ZIP Plus) driver. If the
  cable is marked with "AutoDetect", this is what has
  happened.
scsi : 0 hosts.
/lib/modules/2.2.19/scsi/ppa.o: init_module: Device or resource busy
Hint: insmod errors can be caused by incorrect module parameters, including
invalid IO or IRQ parameters
/lib/modules/2.2.19/scsi/ppa.o: insmod /lib/modules/2.2.19/scsi/ppa.o failed
/lib/modules/2.2.19/scsi/ppa.o: insmod ppa failed


There are the following lines in my modules.conf

alias scsi_hostadapter ppa
alias parport_lowlevel parport_pc
options parport_pc io=0x378 irq=7

--------------B3D5877D3221D1B8EF552B5E--

