Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbUAWJdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbUAWJdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:33:36 -0500
Received: from main.gmane.org ([80.91.224.249]:42632 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265406AbUAWJdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:33:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: logic error in XFS
Date: Fri, 23 Jan 2004 10:33:33 +0100
Message-ID: <yw1xr7xr80wi.fsf@ford.guide>
References: <E1Ajuub-0000xw-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:PkW/sqv3pQDpU2y9uWYn38CPBoI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@redhat.com writes:

> Yet another misplaced ! by the looks..

Sure looks like it.  When is this code encountered?

> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/xfs/xfs_log_recover.c linux-2.5/fs/xfs/xfs_log_recover.c
> --- bk-linus/fs/xfs/xfs_log_recover.c	2003-10-09 01:01:24.000000000 +0100
> +++ linux-2.5/fs/xfs/xfs_log_recover.c	2004-01-14 07:06:40.000000000 +0000
> @@ -1553,7 +1553,7 @@ xlog_recover_reorder_trans(
>  		case XFS_LI_BUF:
>  		case XFS_LI_6_1_BUF:
>  		case XFS_LI_5_3_BUF:
> -			if ((!flags & XFS_BLI_CANCEL)) {
> +			if (!(flags & XFS_BLI_CANCEL)) {
>  				xlog_recover_insert_item_frontq(&trans->r_itemq,
>  								itemq);
>  				break;

-- 
Måns Rullgård
mru@kth.se

