Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTLXOYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 09:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTLXOYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 09:24:13 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:63949 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263622AbTLXOYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 09:24:11 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16361.41348.444243.919179@laputa.namesys.com>
Date: Wed, 24 Dec 2003 17:24:04 +0300
To: Hugang <hugang@soulinfo.com>
Cc: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] laptop-mode for 2.6, version 2
In-Reply-To: <20031224215120.66b74f66.hugang@soulinfo.com>
References: <3FE92517.1000306@samwel.tk>
	<20031224215120.66b74f66.hugang@soulinfo.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugang writes:
 > On Wed, 24 Dec 2003 06:33:11 +0100
 > Bart Samwel <bart@samwel.tk> wrote:
 > 
 > > Here's a new version of the laptop-mode patch (and control script). I've
 > > made a couple of improvements because of your comments. The block_dump
 > > functionality (including block dirtying) is back, and my alternative
 > > functionality has gone. There's just one bit of the block dumping patch 
 > > that I couldn't place, the bit in filemap.c. The 2.6 code is so 
 > > different here that I really couldn't figure out what I should do with 
 > > it. Do you have any idea where this has gone (and if it is still needed)?
 > 
 > Here is hacker patch do laptop mode on reiserfs file system. Any comments are welcome.

>From patch:

+int reiserfs_default_max_commit_age = -1;
+

I am not sure that global variable is a good idea here. What if several
file systems are mounted? You should either pass value as an argument to
the journal initialization code, or just initialize
SB_JOURNAL_MAX_COMMIT_AGE(sb) when parsing options.

 > 
 > -- 
 > Hu Gang / Steve

Nikita.

