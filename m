Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWCTPcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWCTPcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbWCTPcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:32:12 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:1999 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965004AbWCTPcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:32:03 -0500
Date: Mon, 20 Mar 2006 08:32:02 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DoS with POSIX file locks?
Message-ID: <20060320153202.GH8980@parisc-linux.org>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org> <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu> <20060320123950.GF8980@parisc-linux.org> <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 01:52:39PM +0100, Miklos Szeredi wrote:
> Things look fairly straightforward if the accounting is done in
> files_struct instead of task_struct.  At least for POSIX locks.  I
> haven't looked at flocks or leases yet.

I was thinking that would work, yes.  It might not be worth worrying
about accounting for leases/flocks since each process can only have one
of those per open file anyway.

> steal_locks() might cause problems, but that function should be gotten
> rid of anyway.

I quite agree.  Now we need to find a better way to solve the problem it
papers over.
