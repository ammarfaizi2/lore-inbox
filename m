Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUIMHRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUIMHRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUIMHRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:17:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:14019 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266233AbUIMHRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:17:54 -0400
Date: Mon, 13 Sep 2004 00:15:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: pj@sgi.com, bcasavan@sgi.com, ak@suse.de, anton@samba.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: more numa maxnode confusions
Message-Id: <20040913001548.278bf672.akpm@osdl.org>
In-Reply-To: <20040913065621.GB12185@wotan.suse.de>
References: <20040912200253.3d7a6ff5.pj@sgi.com>
	<20040913065621.GB12185@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Sun, Sep 12, 2004 at 08:02:53PM -0700, Paul Jackson wrote:
> >  2) About Aug 9, Brent Casavant sent in a patch changing the set (not get)
> >     side calls, sys_mbind and sys_set_mempolicy, to N64.  This patch
> >     removed the following line from the implementation of get_nodes() in
> >     mm/mempolicy.c:
> > 
> > 	--maxnode;
> 
> Ah, I wasn't aware that this patch got merged into mainline. 
> That was a bad thing, because it broke the ABI used by libnuma
> subtly.
> 
> Please whoever merged it revert it.

Revert what?

> ...
>
> Yes. I appended a patch. Linus or Andrew, please apply it.
> 

Does this patch perform the above reversion, or is something additional
needed?
