Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUJHQKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUJHQKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270039AbUJHQKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:10:32 -0400
Received: from open.hands.com ([195.224.53.39]:42961 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267517AbUJHQKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:10:20 -0400
Date: Fri, 8 Oct 2004 17:20:25 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Brice.Goglin@ens-lyon.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041008162025.GL5551@lkcl.net>
References: <20041008130442.GE5551@lkcl.net> <41669DE0.9050005@didntduck.org> <20041008151837.GI5551@lkcl.net> <4166AFD0.2020905@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4166AFD0.2020905@ens-lyon.fr>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 05:18:40PM +0200, Brice Goglin wrote:
> > call sys_rename, sys_pread, sys_create, sys_mknod, sys_rmdir
> > etc. - everything that does file access.
> 
> If you ever actually call sys_this or sys_that ... from
> the kernel, you'll have to do something like this to avoid
> copy_from/to_user to fail because the target buffer is not
> in kernel space:
> 
> mm_segment_t old_fs;
> old_fs = get_fs();
> set_fs(KERNEL_DS);
> <do you stuff here>
> set_fs(old_fs);
 
 that's it!  that's what i was looking for.  thank you.

 l.
