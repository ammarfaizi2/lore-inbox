Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWFAWZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWFAWZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWFAWZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:25:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:12110 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750751AbWFAWZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:25:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=q8TPw8L6aevZ38Rf2X57+HLQEF66d30VQz68G6zpodikaFaSWiHioJ9aBO/0x9iawWEvnRbwxVpGafcRRBxKci28UgEIMKrgEn2uFXgeCEGnLkjaMXyKpwcnFxrFESMdwXOEVzxPEQu5AcLCg5tKKUxoB2qgNGrn3rmY0KN8EB4=
Message-ID: <986ed62e0606011525g7e742c78s5358255dded7be0e@mail.gmail.com>
Date: Thu, 1 Jun 2006 15:25:31 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
X-Google-Sender-Auth: 36b263fa349d7f13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Got a few build warnings with this one :

On the topic of build warnings, I got these (it's still building, and
some of the earlier build output has gone past screen's scrollback
buffer, so this might not be everything):

drivers/scsi/libsrp.c: In function 'srp_cmd_perform':
drivers/scsi/libsrp.c:434: warning: implicit declaration of function
'scsi_host_get_command'
drivers/scsi/libsrp.c:434: warning: assignment makes pointer from
integer without a cast

ipc/msg.c: In function 'sys_msgctl':
ipc/msg.c:338: warning: 'setbuf.qbytes' may be used uninitialized in
this function
ipc/msg.c:338: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.mode' may be used uninitialized in this function

ipc/sem.c: In function 'sys_semctl':
ipc/sem.c:810: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/sem.c:810: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/sem.c:810: warning: 'setbuf.mode' may be used uninitialized in this function

kernel/lockdep.c: In function 'static_obj':
kernel/lockdep.c:1112: warning: unused variable 'i'

fs/bio.c: In function 'bio_alloc_bioset':
fs/bio.c:169: warning: 'idx' may be used uninitialized in this function

fs/eventpoll.c: In function 'sys_epoll_create':
fs/eventpoll.c:500: warning: 'fd' may be used uninitialized in this function

fs/jfs/jfs_txnmgr.c: In function 'txCommit':
fs/jfs/jfs_txnmgr.c:1922: warning: 'pxd.addr2' may be used
uninitialized in this function
fs/jfs/jfs_txnmgr.c:1922: warning: 'pxd.addr1' may be used
uninitialized in this function
fs/jfs/jfs_txnmgr.c:1922: warning: 'pxd.len' may be used uninitialized
in this function

fs/reiser4/plugin/file/cryptcompress.c: In function 'align_or_cut_overhead':
fs/reiser4/plugin/file/cryptcompress.c:871: warning: 'oh' may be used
uninitialized in this function

fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
fs/xfs/xfs_bmap.c:2498: warning: 'rtx' is used uninitialized in this function

fs/xfs/xfs_dir.c: In function 'xfs_dir_removename':
fs/xfs/xfs_dir.c:363: warning: 'totallen' may be used uninitialized in
this function
fs/xfs/xfs_dir.c:363: warning: 'count' may be used uninitialized in
this function

fs/xfs/xfs_inode.c: In function 'xfs_ifree':
fs/xfs/xfs_inode.c:1960: warning: 'last_offset' may be used
uninitialized in this function
fs/xfs/xfs_inode.c:1958: warning: 'last_dip' may be used uninitialized
in this function

fs/xfs/xfs_log.c: In function 'xlog_write':
fs/xfs/xfs_log.c:1749: warning: 'iclog' may be used uninitialized in
this function

fs/xfs/xfs_log_recover.c: In function 'xlog_find_tail':
fs/xfs/xfs_log_recover.c:523: warning: 'first_blk' may be used
uninitialized in this function

-- 
-Barry K. Nathan <barryn@pobox.com>
