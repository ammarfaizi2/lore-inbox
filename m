Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWBAO0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWBAO0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbWBAO0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:26:20 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:6097 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1161063AbWBAO0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:26:19 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: vitaly@namesys.com
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Wed, 1 Feb 2006 16:25:25 +0200
User-Agent: KMail/1.8.2
Cc: reiserfs-dev@namesys.com, Chris Mason <mason@suse.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <200601281613.16199.vda@ilport.com.ua> <200602011215.54637.vda@ilport.com.ua> <200602011445.05785.vitaly@namesys.com>
In-Reply-To: <200602011445.05785.vitaly@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602011625.25572.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 13:45, Vitaly Fertman wrote:
> On Wednesday 01 February 2006 13:15, Denis Vlasenko wrote:
> > 
> > # reiserfstune -s 1024 /dev/sdc3
> > # mount /dev/sdc3 /.3 -o noatime
> > mount: you must specify the filesystem type
> > 
> > # dmesg | tail -4
> > br: topology change detected, propagating
> > br: port 1(ifi) entering forwarding state
> > FAT: bogus number of reserved sectors
> > VFS: Can't find a valid FAT filesystem on dev sdc3.
> > 
> > # reiserfsck /dev/sdc3
> > reiserfsck 3.6.11 (2003 www.namesys.com)
> 
> your reiserfsprogs are old. which kernel are you using?

# uname -a
Linux pegasus 2.6.12.3-2 #1 SMP Thu Sep 15 11:04:37 EEST 2005 i686 unknown unknown GNU/Linux
 
> as I can see 3.6.11 had that problem indeed, however I have no 
> problem with progs 3.6.19 and kernel 2.6.9 even after shrinking 
> the journal with tune 3.6.11.

Updated to reiserfsprogs-3.6.19. How to fix /dev/sdc3 now?
--
vda
