Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266184AbUALNvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 08:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUALNvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 08:51:50 -0500
Received: from [211.167.76.68] ([211.167.76.68]:34758 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S266184AbUALNvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 08:51:49 -0500
Date: Mon, 12 Jan 2004 21:32:13 +0800
From: Hugang <hugang@soulinfo.com>
To: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Message-Id: <20040112213213.6f507d13@localhost>
In-Reply-To: <4002A3FC.3000000@samwel.tk>
References: <3FFFD61C.7070706@samwel.tk>
	<200401121212.44902.lkml@kcore.org>
	<4002836A.8050908@samwel.tk>
	<200401121343.34688.lkml@kcore.org>
	<4002A3FC.3000000@samwel.tk>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004 14:41:16 +0100
Bart Samwel <bart@samwel.tk> wrote:

> How are the WRITEs grouped, are they grouped together or do they seem to 
> occur more evenly spaced? When you use "sync", how long until the next 
> WRITE? What are the values of /proc/sys/vm/dirty_expire_centisecs and 
> /proc/sys/vm/dirty_writeback_centisecs? Are you sure you are running a 
> kernel that supports the commit= option with reiserfs? (This option was 
> added in 2.6.1.)
> 
> I've never tested laptop mode with reiserfs BTW, does anybody else here 
> have experience with laptop mode and reiserfs?
Yes, I'm use reiserfs in 2.6.1 with laptop_mode patch. It works fine for me, I use cpudyn daemon to let spin download harddisk. In cpudyn.conf
I changed TIMEOUT from 120 to 10. When i reading email/web, the harddisk can spin down for very long time (>3min). 

So you can try cpudynd.


# TIMEOUT=120
TIMEOUT=10

# 
# Specified disks to spindown (comma separated devices)
#

# DISKS=/dev/hda,/dev/hdb
DISKS=/dev/hda


-- 
Hu Gang / Steve
RLU#          : 204016 [1999] (Registered Linux user)
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
