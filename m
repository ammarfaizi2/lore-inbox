Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWDYHp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWDYHp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWDYHp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:45:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33409 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751395AbWDYHp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:45:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: __FILE__ gets expanded to absolute pathname
Date: Tue, 25 Apr 2006 10:44:57 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251044.57373.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime ago I noticed that __FILE__ gets expanded into
*absolute* pathname if one builds kernel in separate object directory.

I thought a bit about it but failed to arrive at any sensible
solution.

Any thoughs?
--
vda

# strings vmlinux | grep /usr/src
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/3c505.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/arch/i386/kernel/time.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/linux/rwsem.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/arch/i386/kernel/smp.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/sched.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/fork.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/profile.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/exit.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/softirq.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/sysctl.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/linux/highmem.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/workqueue.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/mutex.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/mutex-debug.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/futex.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/kernel/irq/manage.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/linux/pagemap.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/mempool.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/oom_kill.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/page_alloc.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/memory.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/mmap.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/rmap.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/vmalloc.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/swapfile.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/hugetlb.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/mm/slab.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/file_table.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/linux/buffer_head.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/buffer.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/locks.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/dcache.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/inode.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/linux/writeback.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/fs-writeback.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/proc/inode.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/proc/base.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/proc/generic.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/sysfs/sysfs.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/reiserfs/inode.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/reiserfs/journal.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/ext3/balloc.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/ext3/fsync.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/ext3/inode.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/ext3/namei.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/ext3/super.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/jbd/transaction.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/jbd/commit.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/jbd/recovery.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/jbd/checkpoint.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/jbd/revoke.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/jbd/journal.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/fat/fatent.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/nfs/write.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/nfs/nfs4proc.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/lockd/svcsubs.c
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: In cifs_put_super
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: Empty cifs superblock info passed to unmount
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: CIFS VFS: leaving %s (xid = %d) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: Devname: %s flags: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: cifs_min_small set to maximum (256)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: found oplock item to write out
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: Oplock flush inode %p rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: Oplock release rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: cifs_max_pending set to min of 2
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsfs.c: cifs_max_pending set to max of 256
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: can not send cmd %d while umounting
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: gave up waiting on reconnect in smb_init
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: reconnect tcon rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: share mode security
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: server UID changed
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In tree disconnect
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Tree disconnect failed %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In SMBLogoff for session disconnect
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Error in RMFile = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSSMBRmDir
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Error in RMDir = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSSMBMkDir
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Error in Mkdir = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: unknown disposition %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Error in Open = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Reading %d bytes on fid %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: bad length %d for count %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in write = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: write2 at %lld %d bytes
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error Write2 = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSSMBLock - timeout %d numLock %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in Lock = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSSMBClose
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSSMBRename
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in rename = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Rename to File by handle
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in Rename (by file handle) = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSSMBCopy
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in copy = %d with %d files copied
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In Symlink Unix style
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in SetPathInfo (create symlink) = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In Create Hard link Unix style
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in SetPathInfo (hard link) = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSCreateHardLink
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in hard link (NT rename) = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In QPathSymLinkInfo (Unix) for path %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in QuerySymLinkInfo = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: parms start after end of smb
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: parm end after end of smb
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: data starts after end of smb
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: data %p + count %d (%p) ends after end of smb %p start %p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: parm count and data count larger than SMB
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In Windows reparse style QueryLink for path %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in QueryReparseLinkInfo = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: reparse buf extended beyond SMB
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Invalid return data count on get reparse info ioctl
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: readlink result - %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: GetCifsACL
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in QuerySecDesc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In SMBQPath path %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in QueryInfo = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in QPathInfo = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In QPathInfo (Unix) the path %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In FindFirst for %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Error in FindFirst = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In FindNext
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: FindNext returned = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSSMBFindClose
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In GetSrvInodeNum for %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: error %d in QueryInternalInfo
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Illegal size ret in QryIntrnlInf
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In GetDFSRefer the path %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in GetDFSRefer = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Decoding GetDFSRefer response.  BCC: %d  Offset %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: num_referrals: %d dfs flags: 0x%x ...
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: OldQFSInfo
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in QFSInfo = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: qfsinf resp BCC: %d  Offset %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Blocks: %lld  Free: %lld Block size %ld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In QFSInfo
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In QFSAttributeInfo
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In QFSDeviceInfo
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in QFSDeviceInfo = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In QFSUnixInfo
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In SETFSUnixInfo
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In QFSPosixInfo
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in QFSUnixInfo = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In SetEOF
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: SetPathInfo (file size) returned %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: SetFileSize (via SetFileInfo) %lld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in SetFileInfo (SetFileSize) = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Set Times (via SetFileInfo)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Send error in Set Time (SetFileInfo) = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In SetTimes
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: SetPathInfo (times) returned %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In SetUID/GID/Mode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: SetPathInfo (perms) returned %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: In CIFSSMBNotify for file handle %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifssmb.c: Error in Notify = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Reconnecting tcp session
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: State: 0x%x Flags: 0x%lx
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Post shutdown state: 0x%x Flags: 0x%lx
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: reconnect error %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: invalid transact2 word count
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: total data %d smaller than data in frame %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: missing %d bytes from transact2, check next response
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: total data sizes of primary and secondary t2 differ
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: transact2 2nd response contains too much data
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: found the last secondary response
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Demultiplex PID: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Reconnect after server stopped responding
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: call to reconnect done
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: tcp session abend after SMBnegprot
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: cifsd thread killed
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Reconnect after unexpected peek error %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Frame under four bytes received (%d bytes long)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: rfc1002 length 0x%x)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Good RFC 1002 session rsp
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Negative RFC1002 Session Response Error 0x%x)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Clearing Mid 0x%x - waking up
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Wait for exit from demultiplex thread
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Null separator not allowed
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Domain name set
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: iocharset set to %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: invalid (empty) netbiosname specified
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: empty server netbiosname specified
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Next tcon -
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c:  old ip addr: %x == new ip %x ?
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Matched ip, old UNC: %s == new: %s ?
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Matched UNC, old user: %s == new: %s ?
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: CIFS Tcon rc = %d ipc_tid = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Socket created
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Error %d connecting to server via ipv4
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: sndbuf %d rcvbuf %d rcvtimeo 0x%lx
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: ipv6 Socket created
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Error %d connecting to server via ipv6
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Username: %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: UNC: %s ip: %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: CIFS VFS: leaving %s (xid = %d) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Existing tcp session with server found
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Existing smb sess found
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Existing smb sess not found
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: readsize set to minimum 2048
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: file mode: 0x%x  dir mode: 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: mounting share using direct i/o
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Found match on UNC path
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: CIFS Tcon rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: No session or bad tcon
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: server negotiated posix acl support
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: negotiated posix pathnames support
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: posix pathnames support requested but not supported
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: In sesssetup
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c:  Guest login
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: UID = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: NT4 server
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Variable field of length %d extends beyond end of smb
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: In spnego sesssetup
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Security Blob Length %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: In NTLMSSP sesssetup (negotiate)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Unexpected NTLMSSP message type received %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: NTLMSSP Challenge rcvd
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: In NTLMSSPSessSetup (Authenticate)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Does UID on challenge %d match auth response UID %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: NTLMSSP response to Authenticate
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Tcon flags: 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: About to do SMBLogoff
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Waking up socket by sending it signal
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Security Mode: 0x%x Capabilities: 0x%x Time Zone: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: New style sesssetup
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: NTLMSSP sesssetup
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: Can use more secure NTLM version 2 password hash
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/connect.c: CIFS Session Established successfully
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c: Create flag not set in create function
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c: CIFS VFS: leaving %s (xid = %d) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c: cifs_create returned 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c: Create worked but get_inode_info failed rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c: Exclusive Oplock for inode %p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c: sfu compat create special file
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c:  parent inode = 0x%p name is: %s and dentry = 0x%p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c:  non-NULL inode in lookup
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c:  NULL inode in lookup
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c:  Full path: %s inode = 0x%p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/dir.c: neg dentry 0x%p name = %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: CIFS VFS: leaving %s (xid = %d) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c:  inode = 0x%p file flags are 0x%x for %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: cifs_open returned 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: inode unchanged on server
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: invalidating remote inode since open detected it changed
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Exclusive Oplock granted on inode %p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: failed file reopen, no valid name if dentry freed
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: oplock: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: closing last open instance for inode %p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Closedir inode = 0x%p with
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Freeing private data in close dir
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Closing uncompleted readdir with rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: closedir free smb buf in srch struct
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: closedir free resume name
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Lock parm: 0x%x flockflags: 0x%x flocktype: 0x%x start: %lld end: %lld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Posix
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Flock
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Blocking lock
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Process suspended by mandatory locking - not implemented yet
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Lease on file - not implemented yet
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Unknown lock flags 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: F_WRLCK
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: F_UNLCK
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: F_RDLCK
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: F_EXLCK
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: F_SHLCK
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Unknown type of lock
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: write %zd bytes to offset %lld of %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: failed on reopen file in wp
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: No writeable filehandles for inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: ppw - page not up to date
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: commit write for page %p up to position %lld for %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Illegal offsets, can not copy from %d to %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Sync file - name: %s datasync: 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Flush inode %p file %p rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: attempting read on write only file instance
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Validation prior to mmap failed, error=%d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Add page cache failed
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Read error in readpages: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: No bytes read (%d) at offset %lld . Cleaning remaining pages from readahead list
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: Bytes read %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: readpage %p at offset %d 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/file.c: prepare write for page %p from %d to %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Getting info on %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Old time %ld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: New time %ld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: unknown type %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: allocation size less than end of file
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Size %ld and blocks %ld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: File inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Directory inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Symbolic Link inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Init special inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Block device
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Char device
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Symlink
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Getting info on %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: No need to revalidate cached inode sizes
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: GetSrvInodeNum rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Unrecognized sfu inode type
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: sfu mode 0%o
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: cifs_unlink, inode = 0x%p with
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: CIFS VFS: leaving %s (xid = %d) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: In cifs_mkdir, mode = 0x%x inode = 0x%p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: cifs_mkdir returned 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: cifs_rmdir, inode = 0x%p with
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: rename rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Revalidate: %s inode 0x%p count %d dentry: 0x%p d_time %ld jiffies %ld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Have to revalidate file due to hardlinks
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: error on getting revalidate info %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: cifs_revalidate - inode unchanged
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Invalidating read ahead data on closed file
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: In cifs_setattr, name = %s attrs->iavalid 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: SetFSize for attrs rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Wrt seteof rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: SetEOF by path (setattrs) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: wrt seteof rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: UID changed to %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: GID changed to %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: Mode changed to 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: CIFS - CTIME changed
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: calling SetFileInfo since SetPathInfo for times not supported by this server
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/inode.c: In cifs_delete_inode, inode = 0x%p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: CIFS VFS: leaving %s (xid = %d) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: Full path: %s inode = 0x%p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: Full path: %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: symname is %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: Create symlink worked but get_inode_info failed with rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: Full path: %s inode = 0x%p pBuffer = 0x%p buflen = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: Error closing junction point (open for ioctl)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: Get DFS for %s rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: num referral: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: referral string: %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/link.c: vfs_readlink called from cifs_readlink returned %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: warning: more than 65000 requests active
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: Null buffer passed to sesInfoFree
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: Null buffer passed to tconInfoFree
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: Null buffer passed to cifs_small_buf_release
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: Multiuser mode and UID did not match tcon uid
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: found matching uid substitute right smb_uid
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: local UID found but smb sess with this server does not exist
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: Checking for oplock break or dnotify response
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: dnotify on %s with action: 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: notify err 0x%d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: invalid handle on oplock break
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c:  oplock type 0x%d level 0x%d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: file id match, oplock break
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: about to wake up oplock thd
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: No matching file for oplock break
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/misc.c: Can not process oplock break for non-existent connection
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/netmisc.c: IPv6 addresses not supported for CIFS mounts yet
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/netmisc.c:  !!Mapping smb error code %d to POSIX err %d !!
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/transport.c: For smb_command %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/transport.c: Sending smb of length %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/transport.c: Sending smb:  total_len %d
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/transport.c
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/transport.c: tcp session dead - return to caller to retry
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/transport.c: marking request for retry
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/transport.c: Bad MID state?
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error decoding negTokenInit header
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: cls = %d con = %d tag = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error decoding negTokenInit header
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error decoding negTokenInit
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: cls = %d con = %d tag = %d end = %p (%d) exit 0
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error decoding 2nd part of negTokenInit
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: cls = %d con = %d tag = %d end = %p (%d) exit 1
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error 1 decoding negTokenInit header exit 2
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: OID len = %d oid = 0x%lx 0x%lx 0x%lx 0x%lx
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: This should be an oid what is going on?
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error decoding last part of negTokenInit exit 3
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Exit 4 cls = %d con = %d tag = %d end = %p (%d)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error decoding last part of negTokenInit exit 5
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Exit 6 cls = %d con = %d tag = %d end = %p (%d)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error decoding last part of negTokenInit exit 7
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Exit 8 cls = %d con = %d tag = %d end = %p (%d)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Error decoding last part of negTokenInit exit 9
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Exit 10 cls = %d con = %d tag = %d end = %p (%d)
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/asn1.c: Need to call asn1_octets_decode() function for this %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/cifsencrypt.c: dummy signature received for smb command 0x%x
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/fcntl.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/fcntl.c: notify rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/fcntl.c: CIFS VFS: leaving %s (xid = %d) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: For %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: May be sparse file, allocation less than file size
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: File Size %ld and blocks %ld and blocksize %ld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: File inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: inode exists but unchanged
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: invalidate inode, readdir detected change
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Directory inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Symbolic Link inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Init special inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: unknown inode type %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Special inode
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Full path: %s start at: %lld
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Unicode string longer than PATH_MAX found
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: new entry %p old entry %p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Unknown findfirst level %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: search backing up - close and restart search
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: freeing SMB ff cache buf on search rewind
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: error %d reinitiating a search on rewind
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: calling findnext2
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: found entry - pos_in_buf %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Entry is .
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: Entry is ..
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: index not in buffer - could not findnext into it
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: can not return entries pos_in_buf beyond last entry
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: filldir rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: CIFS VFS: leaving %s (xid = %d) rc = %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: initiate cifs search rc %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: End of search, empty dir
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: fce error %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: entry %lld found
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: could not find entry
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: loop through %d times filling dir for net buf %p
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/readdir.c: last entry in buf at pos %lld %s
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/ioctl.c: CIFS VFS: in %s as Xid: %d with uid: %d
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/ioctl.c: ioctl file %p  cmd %u  arg %lu
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/ioctl.c: User unmount attempted
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/ioctl.c: uids do not match
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/ioctl.c: unsupported ioctl
<7> /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/fs/cifs/ioctl.c: CIFS VFS: leaving %s (xid = %d) rc = %d
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/block/ll_rw_blk.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/block/as-iosched.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/block/cfq-iosched.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/linux/ioprio.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/lib/kobject.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/lib/kref.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/lib/vsprintf.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/arch/i386/lib/usercopy.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/pci/quirks.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/pci/search.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/acpi/osl.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/acpi/ec.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/char/vt.c
<7>/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/i8042.c: %02x <- i8042 (flush, %s) [%d]
<7>/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/i8042.c: %02x -> i8042 (command) [%d]
<7>/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/i8042.c: %02x -> i8042 (parameter) [%d]
<7>/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/i8042.c: %02x <- i8042 (return) [%d]
<7>/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/i8042.c: %02x -> i8042 (kbd-data) [%d]
<7>/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/i8042.c: Interrupt %d, without any data [%d]
<7>/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/i8042.c: MUX error, status is %02x, data is %02x [%d]
<7>/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/i8042.c: %02x <- i8042 (interrupt, %s, %d%s%s) [%d]
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/serio/libps2.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/serial/serial_core.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/base/core.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/base/class.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/e1000/e1000_main.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/3c59x.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/tg3.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/8139cp.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/8139too.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/r8169.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/scsi/scsi_lib.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/scsi/aic7xxx/aic7xxx_osm.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/scsi/aic7xxx/aic79xx_osm.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/scsi/libata-core.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/scsi/libata-scsi.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/scsi/ahci.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/scsi/sata_promise.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/scsi/sata_sx4.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/input/mouse/psmouse-base.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/net/dst.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/sock.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/request_sock.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/skbuff.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/datagram.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/stream.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/dev.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/link_watch.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/filter.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/core/net-sysfs.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/sched/sch_generic.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/sched/act_police.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/netlink/af_netlink.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/net/sock.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/ip_fragment.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/ip_output.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/inet_hashtables.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/net/inet_hashtables.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/inet_timewait_sock.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/inet_connection_sock.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/include/net/request_sock.h
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/tcp.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/tcp_input.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/tcp_timer.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/tcp_ipv4.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/devinet.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/af_inet.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/ipv4/igmp.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/xfrm/xfrm_policy.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/xfrm/xfrm_state.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/xfrm/xfrm_algo.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/unix/af_unix.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/packet/af_packet.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/key/af_key.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/bridge/br_if.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/sunrpc/clnt.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/sunrpc/sched.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/sunrpc/svcsock.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/sunrpc/rpc_pipe.c
/.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/net/8021q/vlan.c
