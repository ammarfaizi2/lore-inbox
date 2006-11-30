Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031544AbWK3WLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031544AbWK3WLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031547AbWK3WLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:11:31 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:28653 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031544AbWK3WLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:11:30 -0500
Date: Thu, 30 Nov 2006 14:11:40 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: Re: [PATCH -mm] x86_64 UP needs smp_call_function_single
Message-Id: <20061130141140.a1b7d7cc.randy.dunlap@oracle.com>
In-Reply-To: <1164870000.11036.23.camel@earth>
References: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>
	<20061129174558.3dfd13df.akpm@osdl.org>
	<1164870000.11036.23.camel@earth>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 08:00:00 +0100 Ingo Molnar wrote:

> On Wed, 2006-11-29 at 17:45 -0800, Andrew Morton wrote:
> > No, I think this patch is right - the declaration of the CONFIG_SMP
> > smp_call_function_single() is in linux/smp.h so the !CONFIG_SMP
> > declaration
> > or definition should be there too.
> > 
> > It's still buggy though.  It should disable local interrupts around
> > the
> > call to match the SMP version.  I'll fix that separately. 
> 
> hm, didnt i send an updated patch for that already? See the patch below,
> from many days ago. I sent it after the tsc-sync-rewrite patch.

Hi Ingo,

Has there been a patch for this one?  (UP again, not SMP)

drivers/input/ff-memless.c:384: warning: implicit declaration of function 'local_bh_disable'
drivers/input/ff-memless.c:393: warning: implicit declaration of function 'local_bh_enable'

Thanks,
---
~Randy
config:  http://oss.oracle.com/~rdunlap/configs/config-input-up-header
