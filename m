Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753918AbWKMEux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbWKMEux (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 23:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbWKMEux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 23:50:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753920AbWKMEuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 23:50:52 -0500
Date: Sun, 12 Nov 2006 23:50:39 -0500
From: Dave Jones <davej@redhat.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cmm@us.ibm.com, val_henson@linux.intel.com
Subject: Re: [PATCH] Bring ext2 reservations code in line with latest ext3
Message-ID: <20061113045039.GE6591@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	cmm@us.ibm.com, val_henson@linux.intel.com
References: <200611090841.kA98feVx010502@shell0.pdx.osdl.net> <4557BFD7.5010405@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4557BFD7.5010405@mbligh.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 04:44:07PM -0800, Martin J. Bligh wrote:
 > Did a pass through comparing the functions changed by the ext2
 > reservations patch to current ext3 code. Fixed up comments and
 > typedefs to match latest ext3 code.
 > 
 > Only thing left remaining was the error handling in
 > ext2_try_to_allocate_with_rsv, but it may be OK as is.
 > 
 > Signed-off-by: Martin J. Bligh <mbligh@google.com>

 > +/*
 > + * rsv_is_empty() -- Check if the reservation window is allocated.
 > + * @rsv:		given reservation window to check
 > + *
 > + * returns 1 if the end block is EXT3_RESERVE_WINDOW_NOT_ALLOCATED.
 > + */

s/EXT3/EXT2/ ?

 >  static inline int rsv_is_empty(struct ext2_reserve_window *rsv)
 >  {
 >  	/* a valid reservation end block could not be 0 */
 >  	return (rsv->_rsv_end == EXT2_RESERVE_WINDOW_NOT_ALLOCATED);
 >  }

		Dave

-- 
http://www.codemonkey.org.uk
