Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbUKBTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUKBTvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUKBTu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:50:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24758 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261611AbUKBTuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:50:09 -0500
Message-ID: <4187E4E1.5080304@pobox.com>
Date: Tue, 02 Nov 2004 14:49:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org>
In-Reply-To: <1099413424.7582.5.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> ty den 02.11.2004 Klokka 16:02 (+0400) skreiv Brad Campbell:
> 
> 
>>/raid 192.168.2.81(rw,async,no_root_squash)
>>/raid 192.168.3.80(rw,async,no_root_squash)
>>/raid0 192.168.2.81(rw,async,no_root_squash)
>>/raid0/tmp 192.168.2.81(rw,async,no_root_squash)
>>/raid2 192.168.2.81(rw,async,no_root_squash)
>>/raid2 192.168.3.80(rw,async,no_root_squash)
>>/nfsroot 192.168.2.81(rw,async,no_root_squash)
> 
> 
> You should only have 1 line per directory.
> 
> You are not allowed to export a directory and its child (unless the
> child is on a different partition - which does not appear to be the case
> here).
> 
>   http://nfs.sourceforge.net/nfs-howto/server.html#CONFIG


I'm also seeing stale filehandle problems here in recent kernels.

Setup:  x86 or x86-64, TCP, NFSv4 compiled in to both server and client, 
but not specified in mount options.

This is readily reproducible with rsync -- I just boot to an earlier 
version of the kernel on the NFS client, and the stale filehandle 
problems go away.

	JEff



