Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWBCAUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWBCAUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWBCAUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:20:16 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:54683 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964821AbWBCAUO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:20:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jqxg4elTOU2qiqquTZu4Rs7cA6GhZXjc+OM425vVFtpHTJE9Pgk9AJ4K86FthTRhVIqnZPw32VsJK34WBpxgJiym/h+6jwIeIIWJXSqcYL4eM6pIrcbM3W7vXGH6UxrXSbns/r9B1x9/sdgPBrnftwzgshJEQd00AKuZFWRhnJ4=
Message-ID: <6bffcb0e0602021612j29e1f3a4v@mail.gmail.com>
Date: Fri, 3 Feb 2006 01:12:58 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm3
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20060202142041.6222e846.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <43D7A047.3070004@yahoo.com.au>
	 <6bffcb0e0601261102j7e0a5d5av@mail.gmail.com>
	 <43D92754.4090007@yahoo.com.au> <43D927F6.9080807@yahoo.com.au>
	 <6bffcb0e0601270211v787f91d2r@mail.gmail.com>
	 <43E0718F.1020604@yahoo.com.au>
	 <20060201005106.35ca4b8c.akpm@osdl.org>
	 <6bffcb0e0602021306l6b6c1423r@mail.gmail.com>
	 <20060202142041.6222e846.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/06, Andrew Morton <akpm@osdl.org> wrote:
> I actually meant `l *0xb0161cdd' so we get file-n-line.  But from that, it
> appears that we won't get very interesting info anyway.

(gdb) list *0xb0161cdd
0xb0161cdd is in do_path_lookup (/usr/src/linux-mm/fs/namei.c:1124).
1119
1120                    fput_light(file, fput_needed);
1121            }
1122            read_unlock(&current->fs->lock);
1123            current->total_link_count = 0;
1124            retval = link_path_walk(name, nd);
1125    out:
1126            if (nd && nd->dentry && nd->dentry->d_inode)
1127                    audit_inode(name, nd->dentry->d_inode, flags);
1128    out_fail:

Regards,
Michal Piotrowski
