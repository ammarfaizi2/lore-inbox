Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUHTM2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUHTM2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUHTM2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:28:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:36743 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266708AbUHTM2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:28:05 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: fsteiner-mail@bio.ifi.lmu.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel@wildsau.enemy.org, diablod3@gmail.com
In-Reply-To: <4125E5B9.nail8LD2EG3NM@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <4125E5B9.nail8LD2EG3NM@burner>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093001143.30940.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 12:25:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 12:51, Joerg Schilling wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > You can also erase the drive firmware as a user etc. That's the problem.
> 
> This is definitely not a "hot" problem so there is absolutely no reason to 
> make incompatible changes in the kernel interface _without_ discussing this
> with the most important users before.

It becomes a hot problem they second someone posts the example code to
bugtraq.

> On a decently administrated Linux system, only root is able to send SCSI 
> commands because only root is able to open the apropriate /dev/* entries.

Wrong (as usual)

> cdrecord is designed to be safely installed root and cdrecord is trustworthy - 
> it does not overwrite the drive's firmware.

Running cdrecord setuid may well be the right approach. It can drop
capabilities except CAP_SYS_RAWIO and burn cdroms happily.


