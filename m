Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312515AbSDDAHw>; Wed, 3 Apr 2002 19:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312525AbSDDAHc>; Wed, 3 Apr 2002 19:07:32 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3514 "EHLO e1.esmtp.ibm.com")
	by vger.kernel.org with ESMTP id <S312515AbSDDAH1>;
	Wed, 3 Apr 2002 19:07:27 -0500
Message-ID: <3CAB9910.7040006@us.ibm.com>
Date: Wed, 03 Apr 2002 16:06:40 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shift BKL out of notify_change
In-Reply-To: <3CAB8BB4.8040400@us.ibm.com> <200204032358.g33Nw1S13759@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
>> static int devfs_notify_change (struct dentry *dentry, struct iattr *iattr)
>> {
>>-    int retval;
>>+    int retval=0;
>>     struct devfs_entry *de;
>>     struct inode *inode = dentry->d_inode;
>>-    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
>>+    struct fs_info efs_info = inode->i_sb-nu.generic_sbp;
> 
> What on earth is this change? Some kind of cut-and-paste error?

It must be my twiddle fingers.  It sure wasn't intentional.

-- 
Dave Hansen
haveblue@us.ibm.com

