Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVA3FDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVA3FDC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 00:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVA3FDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 00:03:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:53658 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261646AbVA3FCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 00:02:48 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16892.27225.654129.37858@tut.ibm.com>
Date: Sat, 29 Jan 2005 23:02:17 -0600
To: Greg KH <greg@kroah.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 2
In-Reply-To: <20050129081527.GD7738@kroah.com>
References: <16890.38062.477373.644205@tut.ibm.com>
	<20050129081527.GD7738@kroah.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > On Fri, Jan 28, 2005 at 01:38:22PM -0600, Tom Zanussi wrote:
 > > +extern void * alloc_rchan_buf(unsigned long size,
 > > +			      struct page ***page_array,
 > > +			      int *page_count);
 > > +extern void free_rchan_buf(void *buf,
 > > +			   struct page **page_array,
 > > +			   int page_count);
 > 
 > As these will be "polluting" the global namespace of the kernel, could
 > you add "relayfs_" to the front of them?
 > 
 > Also, any reason why you haven't exported the fops of relayfs so that
 > others can use this in their filesystems (like proc and debugfs)?
 > 

No reason - I just forgot.  I'll make sure that gets fixed along with
all the other things you pointed out here in the next patch.

Thanks,

Tom


