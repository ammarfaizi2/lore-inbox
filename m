Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbVAFUSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbVAFUSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVAFUQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:16:30 -0500
Received: from zeus.kernel.org ([204.152.189.113]:22721 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263011AbVAFUKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:10:42 -0500
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
In-Reply-To: <20050106190538.GB1618@us.ibm.com>
References: <20050106190538.GB1618@us.ibm.com>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 20:20:58 +0100
Message-Id: <1105039259.4468.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 11:05 -0800, Paul E. McKenney wrote:
> Hello, Andrew,
> 
> Some export-removal work causes breakage for an out-of-tree filesystem.
> Could you please apply the attached patch to restore the exports for
> files_lock and set_fs_root?


> diff -urpN -X ../dontdiff linux-2.5/fs/namespace.c linux-2.5-MVFS/fs/namespace.c
> --- linux-2.5/fs/namespace.c	Wed Jan  5 13:54:22 2005
> +++ linux-2.5-MVFS/fs/namespace.c	Wed Jan  5 17:12:08 2005

isn;t clearcase (mvfs) a binary only kernel module, and isn't it so that
we don't export specifically for such (potentially license violating)
modules ?

