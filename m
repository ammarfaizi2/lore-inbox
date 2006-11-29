Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758235AbWK2AqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758235AbWK2AqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758248AbWK2AqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:46:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:1760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758235AbWK2AqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:46:20 -0500
Date: Tue, 28 Nov 2006 16:45:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, aia21@cantab.net
Subject: Re: [PATCH 1/2] lib + ntfs: let modules force HWEIGHT
Message-Id: <20061128164538.d95e8498.akpm@osdl.org>
In-Reply-To: <20061128140840.f87540e8.randy.dunlap@oracle.com>
References: <20061128140840.f87540e8.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 14:08:40 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> NTFS (=m) uses hweight32(), but that function is only linked
> into the kernel image if it is used inside the kernel image,
> not in loadable modules.  Let modules force HWEIGHT to be
> built into the kernel image.  Otherwise build fails:
> 
>   Building modules, stage 2.
>   MODPOST 94 modules
> WARNING: "hweight32" [fs/ntfs/ntfs.ko] undefined!
> 
> Yes, I'd certainly prefer for this to be more automated rather than
> forced by each module that needs it.

Perhaps we should just put it in lib-y and remove CONFIG_GENERIC_HWEIGHT.
It's either part of the API or it ain't.
