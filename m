Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265696AbUGDOXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbUGDOXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 10:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUGDOXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 10:23:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20154 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265696AbUGDOXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 10:23:05 -0400
Message-ID: <40E812B8.8010603@pobox.com>
Date: Sun, 04 Jul 2004 10:22:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fawad Lateef <fawad_lateef@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need help in creating 8GB RAMDISK
References: <20040704092523.58214.qmail@web20806.mail.yahoo.com>
In-Reply-To: <20040704092523.58214.qmail@web20806.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fawad Lateef wrote:
> Hello
> 
> I am creating a RAMDISK of 7GB (from 1GB to 8GB). I
> reserved the RAM by changing the code in
> arch/i386/mm/init.c .......... 

On i386 I'm not surprised this ties at 4G.  It's probably too much 
trouble to make part of the ramdisk highmem, and part not.


> Can any one tell me the reason behind this ??? I think
> that in a single module we can't access more than 4GB
> RAM ...... If this is the reason then what to do ??? I
> need 7GB RAMDISK as a single drive ....

Just use ramfs.  Then you don't waste the overhead of putting a 
filesystem on top of the ramdisk.

	Jeff


