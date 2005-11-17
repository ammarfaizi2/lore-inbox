Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161153AbVKQFwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbVKQFwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 00:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVKQFwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 00:52:41 -0500
Received: from pat.uio.no ([129.240.130.16]:39412 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932481AbVKQFwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 00:52:41 -0500
Subject: Re: nfs3 implementation issue?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c140511162135j7a72299eg8223dfedab8eea62@mail.gmail.com>
References: <4ae3c140511162135j7a72299eg8223dfedab8eea62@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 00:52:27 -0500
Message-Id: <1132206747.8029.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.947, required 12,
	autolearn=disabled, AWL 1.87, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 00:35 -0500, Xin Zhao wrote:
> In nfs/nfs3proc.c: nfs3_read_done(), I saw the following line:
> 
>    struct nfs_write_data *data = (struct nfs_write_data *) task->tk_calldata;
> 
> I don't know why the tk_calldata is regarded as nfs_write_data instead
> of nfs_read_data. When this rpc call is set up, we put
> task->tk_calldata as a nfs_read_data object, why will it become a
> nfs_write_data after the rpc call is done?
> 
> Can someone explain this a little bit?

Already fixed. See

http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=34123da66e613602de5a886b05c875b6a91b8ed2

Cheers,
  Trond

