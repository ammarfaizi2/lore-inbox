Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUKBVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUKBVwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUKBVwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:52:15 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:4484 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262001AbUKBVvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:51:43 -0500
Date: Tue, 2 Nov 2004 16:51:26 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
Message-ID: <20041102215126.GE6694@fieldses.org>
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4187E4E1.5080304@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 02:49:53PM -0500, Jeff Garzik wrote:
> >ty den 02.11.2004 Klokka 16:02 (+0400) skreiv Brad Campbell:
> >
> >
> >>/raid 192.168.2.81(rw,async,no_root_squash)
> >>/raid 192.168.3.80(rw,async,no_root_squash)
> >>/raid0 192.168.2.81(rw,async,no_root_squash)
> >>/raid0/tmp 192.168.2.81(rw,async,no_root_squash)
> >>/raid2 192.168.2.81(rw,async,no_root_squash)
> >>/raid2 192.168.3.80(rw,async,no_root_squash)
> >>/nfsroot 192.168.2.81(rw,async,no_root_squash)
....
> I'm also seeing stale filehandle problems here in recent kernels.
> 
> Setup:  x86 or x86-64, TCP, NFSv4 compiled in to both server and client, 
> but not specified in mount options.
> 
> This is readily reproducible with rsync -- I just boot to an earlier 
> version of the kernel on the NFS client, and the stale filehandle 
> problems go away.

Are any of the people seeing these problems able to reproduce them with
the no_subtree_check export option set?

--b.
