Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbTLKJar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTLKJaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:30:46 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:32693 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264604AbTLKJai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:30:38 -0500
Subject: Re: [2.6.0-test11] reiserfs io failures
From: Vladimir Saveliev <vs@namesys.com>
To: "Max Paynemax.." <payne@freemail.hu>
Cc: linux-kernel@vger.kernel.org, lkml@kcore.org
In-Reply-To: <freemail.20031110152024.4445@fm3.freemail.hu>
References: <freemail.20031110152024.4445@fm3.freemail.hu>
Content-Type: text/plain
Message-Id: <1071135036.26354.49.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 11 Dec 2003 12:30:36 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-10 at 17:20, Max Payne wrote:
> Hi!
> 
> I've got exactly same message on my machines with vanilla
> 2.6.0-test11 kernel. On my IBM notebook and my desktop. Is
> this reiserfs bug?  reiserfsck --rebuild-tree /dev/hdaX
> resolved the problem. But very distressing. Any idea?
> 

These messages indicate that reiserfs meta data block is corrupted. So,
if access to a file requires passing through this node - the file is
unavailable.
Currently, we used to suppose that this kind of corruptions are caused
by hardward faults. However, if one knew a way to encounter this problem
on demand - we would try to find what is causing corruption

> Thanks:
> 
> Max
> 
> | is_leaf: free space seems wrong: level=1, nr_items=41, 
> free_space=65224 rdkey 
> | vs-5150: search_by_key: invalid format found in block
> 283191. Fsck?
> | vs-13070: reiserfs_read_locked_inode: i/o failure occurred
> trying to find stat data of [11 12795 0x0 SD]
> | is_leaf: free space seems wrong: level=1, nr_items=41,
> free_space=65224 rdkey 
> | vs-5150: search_by_key: invalid format found in block
> 283191. Fsck?
> | vs-13070: reiserfs_read_locked_inode: i/o failure occurred
> trying to find stat data of [11 12798 0x0 SD]
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

