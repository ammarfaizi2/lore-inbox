Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270855AbTGVRGD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270859AbTGVRGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:06:03 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:17424 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270855AbTGVRGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:06:02 -0400
Date: Tue, 22 Jul 2003 13:19:40 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kurt Roeckx <Q@ping.be>, linux-kernel@vger.kernel.org
Subject: Re: siginfo pad problem.
Message-ID: <20030722131940.W15481@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030721142259.GA4315@ping.be> <20030722022424.7480af8e.sfr@canb.auug.org.au> <20030721180032.GA26786@ping.be> <20030722095105.5ed2379a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030722095105.5ed2379a.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Tue, Jul 22, 2003 at 09:51:05AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 09:51:05AM +1000, Stephen Rothwell wrote:
> Anywhere this should be used (i.e. only in the kernel), uid_t will be
> __kernel_uid32_t.  The change to this part of the siginfo_t structure has
> not yet propogated to the glibc headers and when it does, it is up to the
> glibc maintainers to make sure it matches what is used inside the kernel.

??
glibc uses <bits/siginfo.h>, in which it uses __uid_t for si_uid fields.
__uid_t is uint32_t on all arches.

	Jakub
