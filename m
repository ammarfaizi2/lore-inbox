Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVAAHNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVAAHNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 02:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVAAHNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 02:13:12 -0500
Received: from cathy.bmts.com ([216.183.128.202]:3998 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S261755AbVAAHNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 02:13:07 -0500
Date: Sat, 1 Jan 2005 02:13:08 -0500
From: Mike Houston <mikeserv@bmts.com>
To: "Joseph D. Wagner" <technojoecoolusa@charter.net>
Cc: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.10 Can't Open Initial Console on FC3
Message-Id: <20050101021308.5a906479.mikeserv@bmts.com>
In-Reply-To: <3khdbt$ffuljg@mxip05a.cluster1.charter.net>
References: <3khdbt$ffuljg@mxip05a.cluster1.charter.net>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It is because you need to use an initrd. Your device nodes in
FC3 are being managed by udev, and you otherwise won't have a
/dev/console or /dev/hda at that stage of the boot. There's also the
matter of LVM, if your root partition is a logical volume. Another
reason you might need an initrd.

Your mkinitrd script in FC3 will take care of these matters for you.

Mike

On Thu, 30 Dec 2004 23:00:14 -0600
"Joseph D. Wagner" <technojoecoolusa@charter.net> wrote:

> The newly compiled kernel gets through everything OK including
> mounting the root file system as read-only EXT3.  However, it
> freezes on the very last line, which says:
> 
>      Warning: unable to open an initial console
> 
> If I switch back over to the kernel that came with the distribution,
> everything boots fine, so I'm assuming the problem lies in the way I
> configured the kernel.
> 
