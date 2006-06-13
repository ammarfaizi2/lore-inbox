Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWFMWb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWFMWb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWFMWb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:31:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56491 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932342AbWFMWb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:31:26 -0400
Subject: Re: How does RAID work with IT8212 RAID PCI card?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Christian H?rtwig <christian.haertwig@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060613160138.GC560@csclub.uwaterloo.ca>
References: <200606131758.45704.christian.haertwig@gmx.de>
	 <20060613160138.GC560@csclub.uwaterloo.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Jun 2006 23:47:27 +0100
Message-Id: <1150238847.2232.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-13 am 12:01 -0400, ysgrifennodd Lennart Sorensen:
> Congratulations.  You have a fake raid card by the sound of it.  A
> hardware raid card would have only shown one drive, while a fake raid
> card expects the driver to work with the bios to find out the setup (and
> handle booting), and then the driver does all the raid work in software.

The IT8212 is not a fake raid card - it depends on the firmware whether
you see a drive per raid volume (hardware raid mode) or not (ATAPI
capable firmware). We've found the raid firmware seems quite
temperamental and there is little performance gain from raid 1 in
hardware over software so using md or device mapper is recommended for
that reason.


