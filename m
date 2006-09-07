Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWIGFSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWIGFSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 01:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWIGFSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 01:18:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:10402 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751536AbWIGFS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 01:18:29 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,223,1154934000"; 
   d="scan'208"; a="122306891:sNHT1436813525"
Subject: Re: [PATCH] x86 microcode: don't check the size
From: Shaohua Li <shaohua.li@intel.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tigran Aivazian <tigran@veritas.com>
In-Reply-To: <44FF9DA8.10007@garzik.org>
References: <1157597227.2782.55.camel@sli10-desk.sh.intel.com>
	 <44FF9DA8.10007@garzik.org>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 13:14:37 +0800
Message-Id: <1157606077.2782.58.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 00:18 -0400, Jeff Garzik wrote:
> Shaohua Li wrote:
> > IA32 manual says if micorcode update's size is 0, then the size is
> > default size (2048 bytes). But this doesn't suggest all microcode
> > update's size should be above 2048 bytes to me. We actually had a
> > microcode update whose size is 1024 bytes. The patch just removed the
> > check.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> Why not explicitly check for zero, rather than removing the questionable 
> less-than test?  The default size logic hasn't disappeared...
We just don't want the default size check. If the size is 0, we still
need use default size. The patch is just for those whose size isn't 0
but smaller than default size.

Thanks,
Shaohua
