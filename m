Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSGLUP7>; Fri, 12 Jul 2002 16:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSGLUP7>; Fri, 12 Jul 2002 16:15:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19584 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316840AbSGLUP5> convert rfc822-to-8bit; Fri, 12 Jul 2002 16:15:57 -0400
Date: Fri, 12 Jul 2002 16:19:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207121955.g6CJtQur018433@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.3.95.1020712160455.12312A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Joerg Schilling wrote:

> Erik Andersen wrote:
> 
> >cdrecord should use the CDROM_SEND_PACKET ioctl, then it would
> >work regardless,
> 
> Wis you ever look at the cdrecord sources?
> 
> Cdrecord relies on libscg which is a generic SCSI transport library.
> It has been first written in August 1986 when I wrote the first SCSI
> pass through driver (for SunOS-3.0) - long before Adapted came out with
> ASPI. In the 16 years of evolution, it has been ported to > 30
> different platforms (not including CPU variants like sparc/x86).
> 
> If you force cdrecord to rely on CD-ROM only interfaces, you make Linux
> unusable in general. Do you really like to create an unusable Linux just
> to avoid creating a usable generic SCSI transport interface?
> Jörg
> 
>  EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
>        js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
>        schilling@fokus.gmd.de		(work) chars I am J"org Schilling
>  URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
> -

As much as I hate IDE, IDE isn't going away. All my systems use SCSI
so on machines that have CD/ROMS, I use your libraries and your tools.

Maybe somebody should make CD/ROM code that directly talks to IDE via
/dev/hdwhatever, instead of expecting you to modify your code that
has worked so well for so long.

SCSI, and your CD/ROM code isn't broken. It does not need to be fixed.
IDE drives are not SCSI drives. They shouldn't be logically connected
at any level below 'block-device'. Some block devices are like SCSI,
both the Fire-wire drives and USB drives are, for instance. IDE drives
are like floppies. You write controller-specific commands to the
controller(s). They don't belong 'connected' to SCSI in any logical
way. 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

