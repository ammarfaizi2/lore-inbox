Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266483AbUBFFOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 00:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUBFFN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 00:13:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18599 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266483AbUBFFN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 00:13:58 -0500
Date: Fri, 6 Feb 2004 00:13:55 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.2-mm1, selinux, and initrd
In-Reply-To: <200402060228.i162SwKo004935@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.44.0402060002580.13144-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 Valdis.Kletnieks@vt.edu wrote:

> The system boots OK (minus selinux functionality of course)if I pass
> 'selinux=0' as a kernel parameter, so I'm suspecting these 3 patches:
> 
> +selinux-01-context-mount-support.patch
> +selinux-02-nfs-context-mounts.patch
> +selinux-03-context-mounts-selinux.patch
> 
> I'm suspecting that try_context_mount() is choking because we haven't
> loaded the policy or anything, so we hit this:
> 
>        rc = try_context_mount(sb, data);
>         if (rc)
>                 goto out;

I'm not sure how you reach this conclusion.

try_context_mount will not return an error unless you specify a context
mount option (which I assume you are not doing) and then have something go
wrong.



- James
-- 
James Morris
<jmorris@redhat.com>



