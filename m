Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWJFJeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWJFJeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWJFJeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:34:01 -0400
Received: from twin.jikos.cz ([213.151.79.26]:39342 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751374AbWJFJeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:34:00 -0400
Date: Fri, 6 Oct 2006 11:33:36 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>
cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.com, adilger@clusterfs.com, ext2-devel@lists.sourceforge.net
Subject: Re: 2.6.18-mm2: ext3 BUG?
In-Reply-To: <20061005171428.636c087c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610061129040.12556@twin.jikos.cz>
References: <45257A6C.3060804@gmail.com> <20061005145042.fd62289a.akpm@osdl.org>
 <4525925C.6060807@gmail.com> <20061005171428.636c087c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Andrew Morton wrote:

> Don't know.  The usual diagnosis for this sort of thing is "your disk 
> shat itself".  Could be a bad disk, bad power supply, bad memory, some 
> piece of kernel code went and trashed some memory, bug in the driver.  
> It's a mystery, sorry.

Actually I have also experienced some ext3 corruption (*) on my virtual 
machine under qemu emulation with 2.6.18-mm3, but I thought my previous 
other "strange" activities were guilty. Now it seems that there could be 
indeed something rotten in ext3 driver. Will try to reproduce, and if I am 
able to do so, I will bisect.

(*) Similar symptoms to the original poster - just fsck finding a few 
orphaned entries and lost blocks, etc.

-- 
Jiri Kosina
