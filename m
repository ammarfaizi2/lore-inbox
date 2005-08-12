Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVHLKGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVHLKGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVHLKGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:06:07 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:64903 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932087AbVHLKGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:06:06 -0400
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works
	fine.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
In-Reply-To: <42FC7372.7040607@aitel.hist.no>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
	 <20050805104025.GA14688@aitel.hist.no>
	 <21d7e99705080503515e3045d5@mail.gmail.com>
	 <42F89F79.1060103@aitel.hist.no>  <42FC7372.7040607@aitel.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Aug 2005 11:32:54 +0100
Message-Id: <1123842774.22460.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-12 at 12:01 +0200, Helge Hafting wrote:
> solveable by resizing.  But the machine will occationally hang, forcing 
> me to
> use the reset button.  I lost my mbox file to this (from an ext3 fs, on 
> raid-1 on scsi.)

Unless you are using data=journal and have turned write cache off on
your IDE drives that is expected. Metadata journalling protects your
file system intgerity. Data journalling is more expensive but will
protect your file integrity if the disk layer is also correctly set up.
Unfortunately the IDE layer defaults the wrong way and despite many
complaints has not been changed. In later 2.6 with modern drives you can
also enable barrier mode on the IDE layer which gives better results
than turning off the write cache.

Alan

