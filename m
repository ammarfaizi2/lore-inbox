Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbUL1Buj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUL1Buj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 20:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbUL1Buj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 20:50:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60828 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262012AbUL1Bud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 20:50:33 -0500
Subject: Re: Linux 2.6.10-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D073E6.3050207@stud.feec.vutbr.cz>
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <58cb370e04122616577e1bd33@mail.gmail.com>
	 <1104157999.20952.40.camel@localhost.localdomain>
	 <20041227203146.GA27615@ime.usp.br>  <41D073E6.3050207@stud.feec.vutbr.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104194716.20898.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 00:45:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 20:43, Michal Schmidt wrote:
> > Unfortunately, with this setup, I could not burn a CD and read a CD-ROM of
> > archived files at the same time.
> 
> I think that's normal.

Correct - IDE lacks "disconnect" so when the bus is locked during
something like a CD verify during a burn you don't get access to the
other device.

> > As it was a nuisance, I decided to put the
> > CD-Writer on the Promise controller, which is an UDMA100 controller and,
> > thus, I thought things would only get better.
> 
> I remember reading somewhere that one should not connect ATAPI devices 
> to the Promise controller.

Again exactly right - some promise controllers don't support ATAPI DMA.

As a general rule:
  Put disks on the host first so they avoid the PCI bus overhead and
dont fill it
  Put CD burners on host if you can
  Use external controllers for slower stuff



