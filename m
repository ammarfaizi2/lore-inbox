Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWJEVeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWJEVeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWJEVeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:34:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5154 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932223AbWJEVeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:34:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=A3g8Gqmd1RBQNAeGyeIoP9BR0IK/ooa/PHpLDTDwndoiWCpcdL5ZW64dhRu0sIMMJqmRy1pVgV/CrsQFYKZcOQJ/Gh8PMosYWkNKKdrh/CBYIqoTtTWsVguN2aTUHx5KzC8+gPkStmSRsL4s7KcssmgSVeVFv1VntZGIv9TGpKQ=
Message-ID: <45257A6C.3060804@gmail.com>
Date: Thu, 05 Oct 2006 23:34:13 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext2-devel@lists.sourceforge.net
Subject: 2.6.18-mm2: ext3 BUG?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while yum update-ing, yum crashed and this appeared in log:
[ 2840.688718] EXT3-fs error (device hda2): ext3_free_blocks_sb: bit already 
cleared for block 747938
[ 2840.688732] Aborting journal on device hda2.
[ 2840.688858] ext3_abort called.
[ 2840.688863] EXT3-fs error (device hda2): ext3_journal_start_sb: Detected 
aborted journal
[ 2840.688869] Remounting filesystem read-only
[ 2840.819816] EXT3-fs error (device hda2): ext3_free_blocks_sb: bit already 
cleared for block 747939
[ 2840.819839] EXT3-fs error (device hda2) in ext3_free_blocks_sb: Journal has 
aborted
[ 2840.819846] EXT3-fs error (device hda2) in ext3_free_blocks_sb: Journal has 
aborted
[ 2840.819852] EXT3-fs error (device hda2) in ext3_free_blocks_sb: Journal has 
aborted
[ 2840.819859] EXT3-fs error (device hda2) in ext3_reserve_inode_write: Journal 
has aborted
[ 2840.819865] EXT3-fs error (device hda2) in ext3_truncate: Journal has aborted
[ 2840.819872] EXT3-fs error (device hda2) in ext3_reserve_inode_write: Journal 
has aborted
[ 2840.819879] EXT3-fs error (device hda2) in ext3_orphan_del: Journal has aborted
[ 2840.819886] EXT3-fs error (device hda2) in ext3_reserve_inode_write: Journal 
has aborted
[ 2841.422114] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422125] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422134] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422150] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422165] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422172] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422209] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422264] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422292] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422348] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422420] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422453] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422597] __journal_remove_journal_head: freeing b_committed_data
[ 2841.422651] journal commit I/O error
[ 2842.098946] attempt to access beyond end of device
[ 2842.098954] hda2: rw=0, want=1622222496, limit=19551105
[ 2842.098964] attempt to access beyond end of device
[ 2842.098970] hda2: rw=0, want=2862991560, limit=19551105
[ 2842.098980] attempt to access beyond end of device
[ 2842.098985] hda2: rw=0, want=2442477896, limit=19551105
[ 2842.098993] attempt to access beyond end of device
[ 2842.098999] hda2: rw=0, want=745051184, limit=19551105
[ 2842.099006] attempt to access beyond end of device
[ 2842.099012] hda2: rw=0, want=2876066312, limit=19551105
[ 2842.099019] attempt to access beyond end of device
[ 2842.099026] hda2: rw=0, want=2996155160, limit=19551105
[ 2842.099033] attempt to access beyond end of device
[ 2842.099038] hda2: rw=0, want=530091296, limit=19551105
[ 2842.099045] attempt to access beyond end of device
[ 2842.099050] hda2: rw=0, want=163997728, limit=19551105
[ 2842.099058] attempt to access beyond end of device
[ 2842.099064] hda2: rw=0, want=1193970848, limit=19551105
[ 2842.099071] attempt to access beyond end of device
[ 2842.099077] hda2: rw=0, want=1781229856, limit=19551105
[ 2842.099085] attempt to access beyond end of device
[ 2842.099092] hda2: rw=0, want=2353439768, limit=19551105
[ 2842.099099] attempt to access beyond end of device
[ 2842.099105] hda2: rw=0, want=608441032, limit=19551105
[ 2842.099112] attempt to access beyond end of device
[ 2842.099118] hda2: rw=0, want=3536917176, limit=19551105
[ 2842.099125] attempt to access beyond end of device
[ 2842.099130] hda2: rw=0, want=1079252368, limit=19551105
[ 2842.099138] attempt to access beyond end of device
[ 2842.099142] hda2: rw=0, want=1532974336, limit=19551105
[ 2842.099149] attempt to access beyond end of device
[ 2842.099154] hda2: rw=0, want=1781229856, limit=19551105
[ 2842.099161] attempt to access beyond end of device
[ 2842.099166] hda2: rw=0, want=1781229856, limit=19551105
[ 2842.099172] Reducing readahead size to 256K

I don't know how to reproduce it and really have no idea what version of -mm 
could introduce it (if any).

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
