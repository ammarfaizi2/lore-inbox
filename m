Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbTDDN1o (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbTDDN0J (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:26:09 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:54796 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263534AbTDDNW7 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 08:22:59 -0500
Date: Fri, 4 Apr 2003 14:34:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       Paolo Zeppegno <zeppegno.paolo@seat.it>, Andi Kleen <ak@muc.de>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [rfc][patch] Memory Binding Take 2 (0/1)
Message-ID: <20030404143421.C25147@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>,
	Paolo Zeppegno <zeppegno.paolo@seat.it>, Andi Kleen <ak@muc.de>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <3E8BCB96.6090908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E8BCB96.6090908@us.ibm.com>; from colpatch@us.ibm.com on Wed, Apr 02, 2003 at 09:50:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 09:50:14PM -0800, Matthew Dobson wrote:
> Alrighty, let's give this another go...
> 
> This patch hasn't changed much.  Just added bitmap_t, typedef'd to 
> unsigned long * for passing around bitmaps without breaking the 
> abstraction.  I think it's good if we can keep the underlying data type 
> hidden to partially future-proof (protect? ;) the code.

Not a good idea.  Se_bit & co are defined to work on unsigned longs arrays.

