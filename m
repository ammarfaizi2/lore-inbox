Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTKTCuR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTKTCuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:50:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41942 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264246AbTKTCuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:50:13 -0500
Date: Wed, 19 Nov 2003 18:42:38 -0800
From: "David S. Miller" <davem@redhat.com>
To: Thomas Habets <thomas@habets.pp.se>
Cc: zaitcev@redhat.com, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: forgotten EXPORT_SYMBOL()s on sparc
Message-Id: <20031119184238.20349f58.davem@redhat.com>
In-Reply-To: <200311191540.24097.thomas@habets.pp.se>
References: <E1AMJBP-0003L5-00@reptilian.maxnet.nu>
	<20031119052327.GF25965@devserv.devel.redhat.com>
	<200311191540.24097.thomas@habets.pp.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003 15:40:15 +0100
Thomas Habets <thomas@habets.pp.se> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Wednesday 19 November 2003 06:23, Pete Zaitcev wrote:
> > The csum_partial is exported by kernel/ksyms.c. Why does it fail?
> 
> Not on sparc? Which file do you mean exactly? There doesn't seem to be any 
> ksyms.c in the arch-independant part, nor in arch/sparc/. 2.6.0-test9

Peter he's right, kernel/ksyms.c got deleted and all EXPORT_SYMBOL()
instances moved to the site of the implementation.

I'll add a cleaned up version of Thomas's original patch to my tree.
