Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbWCPUhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWCPUhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbWCPUhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:37:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964808AbWCPUhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:37:00 -0500
Date: Thu, 16 Mar 2006 12:33:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, janak@us.ibm.com,
       viro@ftp.linux.org.uk, hch@lst.de, mtk-manpages@gmx.net, ak@muc.de,
       paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
Message-Id: <20060316123341.0f55fd07.akpm@osdl.org>
In-Reply-To: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Since we have not crossed the magic 2.6.16 line can we please
>  include this patch.  My apologies for catching this so late in the
>  cycle.
> 
>  - Error if we are passed any flags we don't expect.
> 
>    This preserves forward compatibility so programs that use new flags that
>    run on old kernels will fail instead of silently doing the wrong thing.

Makes sense.

>  - Use separate defines from sys_clone.
> 
>    sys_unshare can't implement half of the clone flags under any circumstances
>    and those that it does implement have subtlely different semantics than
>    the clone flags.  Using a different set of flags sets the
>    expectation that things will be different.

iirc there was some discussion about this and it was explicitly decided to
keep the CLONE flags.

Maybe Janak or Linus can comment?
