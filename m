Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUELODT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUELODT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 10:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUELODT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 10:03:19 -0400
Received: from ns.suse.de ([195.135.220.2]:6283 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265094AbUELODS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 10:03:18 -0400
Date: Wed, 12 May 2004 16:02:11 +0200
From: Andi Kleen <ak@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       yuri@acronis.com, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [2.6.6-BK] x86_64 has buggy ffs() implementation
Message-Id: <20040512160211.40bf63d9.ak@suse.de>
In-Reply-To: <1084369416.16624.53.camel@imp.csi.cam.ac.uk>
References: <1084369416.16624.53.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 14:43:37 +0100
Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> Hi Andi, Andrew, Linus,
> 
> x86_64 has incorrect include/asm-x86_64/bitops.h::ffs() implementation. 
> It uses "g" instead of "rm" in the insline assembled bsfl instruction. 
> (This was spotted by Yuri Per.)
> 
> bsfl does not accept constant values but only memory ones.  On i386 the
> correct "rm" is used.
> 
> This causes NTFS build to fail as gcc optimizes a variable into a
> constant and ffs() then fails to assemble.
> 
> Please apply below patch.  Thanks!

Thanks. I applied it to my tree.

-Andi
