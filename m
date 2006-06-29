Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWF2JR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWF2JR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWF2JR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:17:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:37788 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751821AbWF2JR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:17:56 -0400
X-IronPort-AV: i="4.06,191,1149490800"; 
   d="scan'208"; a="58389686:sNHT32331208"
Subject: Re: [PATCH]microcode update driver rewrite - takes 2
From: Shaohua Li <shaohua.li@intel.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Greg KH <greg@kroah.com>,
       arjan <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       Tigran Aivazian <tigran@veritas.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <44A3B38F.76E4.0078.0@novell.com>
References: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>
	 <20060627060214.GA27469@kroah.com>
	 <1151396103.21189.75.camel@sli10-desk.sh.intel.com>
	 <1151569119.21189.106.camel@sli10-desk.sh.intel.com>
	 <44A3B38F.76E4.0078.0@novell.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 17:15:35 +0800
Message-Id: <1151572535.21189.109.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 11:03 +0200, Jan Beulich wrote:
> I'm not having a problem removing the messages if the current state can be obtained
> elsewhere.
> 
> Looking at the patch I see at least one problem (in more than one place) - before
> accessing data, you should check that the relevant piece to be read is entirely within
> range. You should not (as done at least once) rely on copy_from_user() failing - the
> data may be readable, but out of bounds wrt. the information in the headers (or the
> header sizes themselves).
Can you please give me more details? I had a lot of checks there if the
size is incorrect.

Thanks,
Shaohua
