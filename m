Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUHWRyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUHWRyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHWRyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:54:31 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:30728 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262837AbUHWRy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:54:26 -0400
Date: Mon, 23 Aug 2004 18:54:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, paulus@samba.org, akpm@osdl.org,
       ipseries-list@redhat.com
Subject: Re: [PATCH] ppc64 mf_proc file position fix
Message-ID: <20040823185423.A19476@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, paulus@samba.org, akpm@osdl.org,
	ipseries-list@redhat.com
References: <20040820201032.GA14005@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040820201032.GA14005@cs.umn.edu>; from sleddog@us.ibm.com on Fri, Aug 20, 2004 at 03:10:32PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 03:10:32PM -0500, Dave C Boutcher wrote:
> Andrew, 
> 
> arch/ppc64/kernel/mf_proc.c uses a bad interface for moving 
> along file position in a proc_write routine.  This quit working
> altogether in 2.6.8.  Patch to fix.  And I did a quick scan of the
> kernel to see if anyone else was similarly broken...apparantly not :-)
> 
> Fixes a broken update of f_pos in a proc file write routine.

What about moving on to seq_file while you're at it?  Switching from
one deprecated interface to another doesn't really sound like a worthwile
effort.

