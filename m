Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290918AbSAaErD>; Wed, 30 Jan 2002 23:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290917AbSAaEqx>; Wed, 30 Jan 2002 23:46:53 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36591 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290916AbSAaEqk>;
	Wed, 30 Jan 2002 23:46:40 -0500
Date: Wed, 30 Jan 2002 21:45:52 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Kris Urquhart <kurquhart@littlefeet-inc.com>
Cc: "'Alexander Viro'" <viro@math.psu.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Message-ID: <20020130214552.Q763@lynx.adilger.int>
Mail-Followup-To: Kris Urquhart <kurquhart@littlefeet-inc.com>,
	'Alexander Viro' <viro@math.psu.edu>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <B9F49C7F90DF6C4B82991BFA8E9D547B1256F7@BUFORD.littlefeet-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B9F49C7F90DF6C4B82991BFA8E9D547B1256F7@BUFORD.littlefeet-inc.com>; from kurquhart@littlefeet-inc.com on Wed, Jan 30, 2002 at 05:27:42PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2002  17:27 -0800, Kris Urquhart wrote:
> When using a disk partition, however, the second mount 
> appears to fail, but then yields the exact same results
> as the loop device example.  It appears that the second 
> mount actually replaced the first one, without giving the 
> first one a chance to sync to disk?

It shouldn't have done so.

> + find /mnt/hd -ls
>      2    1 drwxr-xr-x   3 root     root         1024 Dec 31 15:17 /mnt/hd
>     11   12 drwxr-xr-x   2 root     root        12288 Dec 31 15:17
> /mnt/hd/lost+found
> find: /mnt/hd/tar: Input/output error
> find: /mnt/hd/zcat: Input/output error

Any interesting output in 'dmesg' when this happens?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

