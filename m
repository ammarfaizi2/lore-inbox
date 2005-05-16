Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVEPN6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVEPN6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVEPN6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:58:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:47516 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261649AbVEPN5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:57:46 -0400
Date: Mon, 16 May 2005 08:56:45 -0500
From: serue@us.ibm.com
To: Lai Zit Seng <lzs@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root()
Message-ID: <20050516135645.GA5842@serge.austin.ibm.com>
References: <42887147.9000302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42887147.9000302@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lai Zit Seng (lzs@pobox.com):
> Not sure where to post this, forgive me if there is a better place to 
> post...
> 
> I'm trying to use pivot_root() to change root to a directory that is not 
> a mount point, i.e. it is under a mount point of a different device from 
> the current root device.
> 
> E.g.
> 
> # /root is mounted from /dev/sda1
> pivot_root("/root/somewhere", "/root/somewhere/initrd");
> 
> But pivot_root() returns EINVAL. Both /root/somewhere and 
> /root/somewhere/initrd exists.
> 
> Any pointers about what might be wrong? Many thanks :)

Try first doing

	mount --bind <newroot> <newroot>

See the comments above fs/namespace.c:sys_pivot_root() for the
explanation.

-serge
