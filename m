Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWDYJO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWDYJO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWDYJO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:14:27 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:10375 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932159AbWDYJO0
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 25 Apr 2006 05:14:26 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17485.59227.679738.701155@gargle.gargle.HOWL>
Date: Tue, 25 Apr 2006 13:09:47 +0400
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: C++ pushback
Newsgroups: gmane.linux.kernel
In-Reply-To: <20060425001617.0a536488@werewolf.auna.net>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	<mj+md-20060424.201044.18351.atrey@ucw.cz>
	<444D44F2.8090300@wolfmountaingroup.com>
	<1145915533.1635.60.camel@localhost.localdomain>
	<20060425001617.0a536488@werewolf.auna.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon writes:

[...]

 > 
 > Tell me what is the difference between:
 > 
 > 
 >     sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 >     if (!sbi)
 >         return -ENOMEM;
 >     sb->s_fs_info = sbi;
 >     memset(sbi, 0, sizeof(*sbi));
 >     sbi->s_mount_opt = 0;
 >     sbi->s_resuid = EXT3_DEF_RESUID;
 >     sbi->s_resgid = EXT3_DEF_RESGID;
 > 
 > and
 > 
 >     SuperBlock() : s_mount_opt(0), s_resuid(EXT3_DEF_RESUID), s_resgid(EXT3_DEF_RESGID)
 >     {}
 > 
 >     ...
 >     sbi = new SuperBlock;
 >     if (!sbi)
 >         return -ENOMEM;
 > 
 > apart that you don't get members initalized twice and get a shorter code :).

The difference is that second fragment doesn't mention GFP_KERNEL, so
it's most likely wrong. Moreover it's shorter only because it places
multiple initializations on the same like, hence, contradicting
CodingStyle.

 > 
 > --
 > J.A. Magallon <jamagallon()able!es>     \               Software is like sex:

Nikita.
