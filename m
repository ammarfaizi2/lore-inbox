Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279712AbRJYFve>; Thu, 25 Oct 2001 01:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279713AbRJYFvY>; Thu, 25 Oct 2001 01:51:24 -0400
Received: from zok.sgi.com ([204.94.215.101]:32429 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S279712AbRJYFvK>;
	Thu, 25 Oct 2001 01:51:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Castle <dalgoda@ix.netcom.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe problem with block-major-11 
In-Reply-To: Your message of "Wed, 24 Oct 2001 21:53:28 MST."
             <20011024215328.A195@thune.mrc-home.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Oct 2001 15:51:36 +1000
Message-ID: <24102.1003989096@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001 21:53:28 -0700, 
Mike Castle <dalgoda@ix.netcom.com> wrote:
>Currently my modules.conf has:
>options ide-cd ignore=hdc            # tell the ide-cd module to ignore h
>alias block-major-11 sr_mod          # load sr_mod upon access of scd0
>pre-install sg     modprobe ide-scsi # load ide-scsi before sg
>pre-install sr_mod modprobe ide-scsi # load ide-scsi before sr_mod
>pre-install ide-scsi modprobe ide-cd # load ide-cd   before ide-scsi

Is that the complete modules.conf?  The messages below imply that you
have other options and/or commands in there.

>Now, if I try something like ``head /dev/scd0''  I see the following in
>dmesg:
>SCSI subsystem driver Revision: 1.00
>Uniform CD-ROM driver unloaded
>
>And the following in /var/log/ksymoops:
>20011024 214049 start /sbin/modprobe -s -k -- block-major-11 safemode=1
>20011024 214050 probe ended

Check syslog for any error messages.  The only unusual thing is that
modprobe is running in safe mode (user supplied input data) which
suppresses some command expansions.  Post your entire modules.conf
exactly as is, i.e. read the file into your mail, do not cut and paste
it.

