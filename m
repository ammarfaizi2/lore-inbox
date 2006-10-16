Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWJPS4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWJPS4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWJPS4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:56:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:11412 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422817AbWJPS4o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:56:44 -0400
Subject: Re: [Patch] x86_64 hot-add memroy srat.c fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: andrew <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Konrad redhat <konradr@redhat.com>, dick zickus <dzickus@redhat.com>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
In-Reply-To: <200610161201.16140.ak@suse.de>
References: <1160175229.5663.23.camel@keithlap>
	 <200610161201.16140.ak@suse.de>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Mon, 16 Oct 2006 11:56:38 -0700
Message-Id: <1161024998.5664.17.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 12:01 +0200, Andi Kleen wrote:
> On Saturday 07 October 2006 00:53, keith mannthey wrote:
> >   This patch corrects the logic used in srat.c to figure out what
> > parsing what action to take when registering hot-add areas.  Hot-add
> > areas should only be added to the node information for the
> > MEMORY_HOTPLGU_RESERVE case.  When booting MEMORY_HOTPLUG_SPARSE hot-add
> > areas on everything but the last node are getting include in the node
> > data and during kernel boot the pages are setup then the kernel dies
> > when the pages are used. This patch fixes this issue.  It is based
> > against 2.6.19-rc1.  
> 
> Added thanks, especially since it's a obvious typo.
Yea...  Something pre 2.6.19 was removing the e820 reserved area before
the nodes were brought online (and thus masking the problem during
testing). 

> If that patch was added to .19 does sparsemem hotadd work then or does it
> need more patches?

SPARSEMEM hot-add will work in .19 if this patch is applied.  

Thanks,
  Keith 

