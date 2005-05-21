Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVEUTFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVEUTFb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 15:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVEUTFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 15:05:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:35990 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261774AbVEUTFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 15:05:25 -0400
Subject: Re: software RAID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Adam Miller <amiller@gravity.phys.uwm.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050520200334.GF23621@csclub.uwaterloo.ca>
References: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu>
	 <20050520200334.GF23621@csclub.uwaterloo.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116702201.7080.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 21 May 2005 20:03:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-05-20 at 21:03, Lennart Sorensen wrote:
> If a harddisk has a bad sector that is visible to the user (and hence
> not remapped by the drive) then it is time to retire the drive since it
> is out of spares and very damaged by that point.

Sector reads failing due to poweroff during sector write or very
occasionally through vibration or other error may not always indicate
drive replacement is appropriate. Generally yes it does and SMART may
flag it.

Rewriting the sector is a good thing to try as ext2/3 fsck for example
does in this case.

