Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293244AbSCJVTH>; Sun, 10 Mar 2002 16:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293255AbSCJVS4>; Sun, 10 Mar 2002 16:18:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10002 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293244AbSCJVSo>; Sun, 10 Mar 2002 16:18:44 -0500
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
To: r.turk@chello.nl (Rob Turk)
Date: Sun, 10 Mar 2002 21:34:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a6giak$c7o$1@ncc1701.cistron.net> from "Rob Turk" at Mar 10, 2002 10:16:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kAxQ-0007MV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was fabulous at that time. The first time you create a file, it gets ";1"
> appended to it's filename. When you edit it, it gets saved under the same name,
> this time appended by ";2". Edit it again... whell, you get the picture.
> Cleaning up was as simple as "$ PURGE /KEEP=3" to keep the last three versions.
> 
> For these days with sometimes hundreds of files, it might become confusing when
> 'ls' shows all versions of all files, but back then it worked well.

Its trickier than that - because all your other semantics have to align,
its akin to the undelete problem (in fact its identical). Do you version on
a rewrite, on a truncate, only on an O_CREAT ?

In terms of where to stick versions, one popular unix solution seems to be
to put them in a .something directory  (eg the netapp filer)
