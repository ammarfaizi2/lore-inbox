Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWBKV6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWBKV6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWBKV6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:58:17 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:22350 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1750743AbWBKV6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:58:17 -0500
Message-ID: <43EE5DFC.7020908@suse.com>
Date: Sat, 11 Feb 2006 16:58:20 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org, reiser@namesys.com
Subject: Re: kernel-2.6.16-rc2-git8 - reiserfs 3.6 - write problem !!!
References: <200602101830.AA329122124@usfltd.com>
In-Reply-To: <200602101830.AA329122124@usfltd.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

art wrote:
> kernel-2.6.16-rc2-git8 - reiserfs - write problem !!!
> 
> it started ~from kernel-2.6.16-rc2
> 2.6.16-rc1-git6 works ok
> 
> with 2.6.16-rc2-git8
> --reiserfs is 3.6 on ide hdd mounted on /mnt on scsi-hdd with ext3 on it--
> mount
> /dev/hda1 on /mnt/mountpoint-reiserfs type reiserfs (rw)
> /dev/sdb1 on /mnt/mountpoint-ext3 type ext3 (rw)
> 
> [bebe@localhost mnt]$ ls -l -Z
> drwxr-xr-x root root system_u:object_r:file_t mountpoint-ext3
> drwxr-xr-x root root system_u:object_r:file_t mountpoint-reiserfs
> 
> [root@localhost mountpoint-ext3]# ls -Z
> drwxrwxrwx root root root:object_r:file_t abc
> drwxr-xr-x bebe bebe root:object_r:file_t def
> drwx------  root root system_u:object_r:file_t lost+found
> 
> [root@localhost mountpoint-reiserfs]# ls -Z
> drwxr-xr--  bebe bebe system_u:object_r:file_t abc
> drwxr-xr-x  root root system_u:object_r:file_t def
> 
> [bebe@localhost abc]$ su
> Password:
> [root@localhost abc]# ls >xxxxxx
> bash: xxxxxx: Permission denied
> [root@localhost abc]#
> 
> same in targeted and permissive mode in selinux
> 
> up to 2.6.16-rc1-git6 it works OK

Can you post the output of 'lsattr <dir>' where you get permission
denied? Also, please include any relevant dmesg output as well.

-Jeff
