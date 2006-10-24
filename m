Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWJXRJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWJXRJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 13:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWJXRJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 13:09:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7867 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965157AbWJXRJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 13:09:00 -0400
Date: Tue, 24 Oct 2006 18:08:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024170857.GB17956@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Verych <olecom@flower.upol.cz>, linux-kernel@vger.kernel.org
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com> <200610241730.00488.rjw@sisk.pl> <slrnejsfms.93p.olecom@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnejsfms.93p.olecom@flower.upol.cz>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 04:20:31PM +0000, Oleg Verych wrote:
> > Do you mean calling sys_sync() after the userspace has been frozen
> > may not be sufficient?
> 
> Please see
> <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=317479;msg=105;att=0>
> 
> it's bottom of
> <http://bugs.debian.org/317479>
> 
> IMHO it's may be helpful.

It's not.  It'sa step in the wrong direction.  The only way to guarantee
a filesystem (not just xfs, _any_ filesystem - xfs is just most sensitive)
is to call the write_super_lockfs method.

