Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUD1QSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUD1QSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 12:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUD1QSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 12:18:00 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:54144 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264921AbUD1QRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:17:51 -0400
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
	writeback
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040428062942.A27705@infradead.org>
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
	 <20040426191512.69485c42.akpm@osdl.org>
	 <1083035471.3710.65.camel@lade.trondhjem.org>
	 <20040426205928.58d76dbc.akpm@osdl.org>
	 <1083043386.3710.201.camel@lade.trondhjem.org>
	 <20040426225834.7035d2c1.akpm@osdl.org>
	 <1083080207.2616.31.camel@lade.trondhjem.org>
	 <20040428062942.A27705@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083169062.2856.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 12:17:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 01:29, Christoph Hellwig wrote:
> There's nothing speaking against probing for more dirty pages before and
> after the one ->writepage wants to write out and send the big request
> out.  XFS does this to avoid creating small extents when converting from
> delayed allocated space to real extents.

You are referring to xfs_probe_unmapped_page()? True: we could do
that... In fact we could do it a lot more efficiently now that we have
the pagevec_lookup_tag() interface.

Cheers,
  Trond
