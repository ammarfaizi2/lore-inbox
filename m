Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWBPAom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWBPAom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 19:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWBPAom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 19:44:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:43748 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751322AbWBPAol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 19:44:41 -0500
Subject: Re: fsck: i_blocks is xxx should be yyy on ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <20060208225359.426573cf.akpm@osdl.org>
References: <43EA079A.4010108@aitel.hist.no>
	 <20060208225359.426573cf.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 15 Feb 2006 16:44:38 -0800
Message-Id: <1140050679.20936.14.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 22:53 -0800, Andrew Morton wrote:
> Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> >
> >  Today I rebooted into 2.6.16-rc2-mm1.  Fsck checked a "clean" ext3 fs,
> >  because it was many mounts since the last time.
> > 
> >  I have seen that many times, but this time I got a lot of
> >  "i_blocks is xxx, should be yyy fix?"
> > 
> >  In all cases, the blocks were fixed to a lower number.
> 
> Yes, thanks.  It's due to the ext3_getblocks() patches in -mm.  I can't
> think of any actual harm which it'll cause.
> 
> To reproduce:
> 
> mkfs
> mount
> dbench 32
> <wait 20 seconds>
> killall dbench
> umount
> fsck
> -

Sorry about the late response.  I failed to reproduce the problem with
above instructions. I am running 2.6.16-rc2-mm1 kernel, played dbench
32 ,64 and 128, and tried both 8 cpu and 1 cpu, still no luck at last. I
am using e2fsck version 1.35 though. What versions you are using?


Thanks!

Mingming


