Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUGCU0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUGCU0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUGCU0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:26:06 -0400
Received: from [213.146.154.40] ([213.146.154.40]:44233 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265250AbUGCUZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:25:42 -0400
Date: Sat, 3 Jul 2004 21:25:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: procfs permissions on 2.6.x
Message-ID: <20040703202541.GA11398@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040703202242.GA31656@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703202242.GA31656@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 10:22:42PM +0200, Herbert Poetzl wrote:
> 
> Hi Andrew!
> 
> stumbled over the following detail ...
> 
> usually when somebody tries to modify an inode,
> notify_change() calls inode_change_ok() to verify
> the user's permissions ... now it seems that
> somewhere around 2.5.41, a patch similar to this
> one was included into the mainline, and remained
> almost unmodified ...
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.1/1002.html
> 
> this probably unintentionally circumvents the 
> inode_change_ok() check, so that now any user
> can modify inodes of the procfs. 
> 
> example:
> 
>   $ chmod a-rwx /proc/cmdline
> 
> the following patch hopefully fixes this, so
> please consider for inclusion ...

Actually the patch you reference above looks extremly bogus and should just
be reverted instead.

