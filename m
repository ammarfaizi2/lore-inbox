Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbTAFIiU>; Mon, 6 Jan 2003 03:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbTAFIiU>; Mon, 6 Jan 2003 03:38:20 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:531 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id <S266316AbTAFIiT>;
	Mon, 6 Jan 2003 03:38:19 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Derek Fountain <derekfountain@lycos.co.uk>
To: linux-kernel@vger.kernel.org
Subject: LVM, NFS, Reiser and ext3
Date: Mon, 6 Jan 2003 09:47:53 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301060947.53043.derekfountain@lycos.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running SuSE 8.1 with their 2.4.19 kernel on a single CPU i386 box.

I have an volume group consisting of 2 IDE based physical volumes and one SCSI 
based one. I created a logical volume of 5GB, put a Reiser file system on it, 
and exported it using kernel NFS. I then had an NFS client (another SuSE 8.1 
box) write data to it. The result was quickly disasterous. Piles of errors 
from reiserfs, resulting in a fs which fsck couldn't deal with.

I reformatted with ext3 and tried again. Several gigabytes of seemingly 
correctly written NFS transfers later, I'm seeing errors on read like:

Jan  6 16:26:47 beetle kernel: EXT3-fs error (device lvm(58,0)): ext3_readdir: 
bad entry in directory #229383: rec_len is too small for name_len - 
offset=504, inode=229395, rec_len=36, name_len=36

and lots and lots of:

Jan  6 16:29:34 beetle kernel: attempt to access beyond end of device
Jan  6 16:29:34 beetle kernel: 3a:00: rw=0, want=629932036, limit=5242880

Is there reason to believe that LVM, NFS and jouralling file systems don't get 
along?

-- 
Australian Linux Technical Conference 2003: http://www.linux.conf.au/

Explain to your boss the benefits of you going...
