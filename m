Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUHHXFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUHHXFl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 19:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUHHXFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 19:05:40 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:59630 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S265499AbUHHXFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 19:05:37 -0400
Subject: Re: cross-depmod?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040806154211.GB7331@mars.ravnborg.org>
References: <1091742716.28466.27.camel@localhost>
	 <20040806154211.GB7331@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1091963200.27202.10.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 09:05:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 01:42, Sam Ravnborg wrote:
> I assume the problem arises from the fact that depmod are only capable of
> reading elf files for the host it is compiled for.
> OK, took a look at depmod.
> It handles both 32 and 64 bit but assumes same endian.
> 
> Rusty: Would it make sense to extend module-init-tools to support
> endian as specified in elf file?

Frankly, yes.

In my opinion, it makes even more sense for modprobe to do the work
itself, and cache the info in /lib/modules/`uname
-r`/modules.{dep,alias,symtab}.

I was always planning on doing this after we got rid of the modules.map
files, but that never happened due to reluctance from other people to
transition, and I didn't fight them.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

