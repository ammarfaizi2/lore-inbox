Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVAWQuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVAWQuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 11:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVAWQuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 11:50:16 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:28909 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261327AbVAWQuE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 11:50:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nt+mT5nGemJQlLXWHBT6eIQMEdEW62H7ku/Z+T/g7C+5qpkLPZ+FIp6VhEfkD+teGy3cjH3yrjHiK2ce9Dua2jEUqqMAgplRcNcRrU5ds7ffIC19ZzceaXVGzF1LOhsmOpH02qo1TeDNGwEQpNy+5Up5DkXifdd25gXwD1LJzcw=
Message-ID: <58cb370e0501230850185b007f@mail.gmail.com>
Date: Sun, 23 Jan 2005 17:50:04 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: 2.6 more picky about IDE drives than 2.4 ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <csv3ss$a4m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <csv3ss$a4m$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2005 04:00:52 +0100, Sven Köhler <skoehler@upb.de> wrote:
> Hi,

Hi,

> i have many problems with kernel 2.6.10 since it won't run stable with
> an IDE-device. It's an internal IDE-RAID subsystem. The DMA is
> frequently disabled, and even writes/reads fail and the kernel reports
> I/O-Errors for many sectors. The RAID-device doesn't report any errors
> it it's own event-log. You can have a closer look at the error-messages
> below.
> 
> I'm mailing to the LKML, since i haven't been abled to reproduce the
> problem with a kernel 2.4 bases system, but it randomly happens with 2.6
> kernels. Let's take the latest Knoppix as an example (it comes with both
> kernels):
> - if i boot kernel 2.4, i can stress test the harddisk as much as i
> want. the kernel does report any problem and it doesn't disable DMA well
> - if i boot kernel 2.6, after a while, there are the error-message below
> in the log. "hdparm -k1" doesn't help, the kernel will disable DMA mode.
> There was a also a bigger problems for two times now, where the kernel
> refused to write to the devide, due to the I/O-Errors below. I'm very
> sad, that i haven't the log-lines prior to the I/O-Errors.

You didn't give any information about your hardware (controller type,
drives used etc).  Please read REPORTING-BUGS in the kernel source
directory.  Also please find last working kernel version (2.5 or 2.6).

> I testes the RAID-subsystem with two different PC-systems. Always the
> same result: 2.4 works, 2.6 does not. It's hard for me to reproduce the
> Errors through. I'm still writing an application to reliably reproduce
> them :-( Does anybody know a good stress-test perhaps? Sequential
> reading doesn't seem to do the trick.
> 
> What changes have been applied to the IDE subsystem from kernel 2.4 to
> kernel 2.6? What may cause this different behaviour? What does
> "status=0x51" mean? And why is "error=0x00" although the Error-Bit in
> the status-byte has been set. (i guess this is what status=0x51 means).
> 
> How can the behaviour of kernel 2.6 be reverted to the behaviour of
> kernel 2.4? I already tried "hda=nowerr" in the append-line, but it
> doesn't help either. Is it a Bug of kernel 2.6, or should i smash the
> manufactures doors, to make them release a firmware-update of the
> RAID-subsystem since it reports strange values to the OS?

Dunno, I don't have a magic ball... ;)

Bartlomiej
