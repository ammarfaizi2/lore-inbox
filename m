Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVDLWeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVDLWeC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVDLWby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:31:54 -0400
Received: from pat.uio.no ([129.240.130.16]:60388 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262986AbVDLW0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:26:49 -0400
Subject: Re: NFS2 question, help, pls!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c1405041212223ee0609e@mail.gmail.com>
References: <4ae3c1405041212223ee0609e@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 15:26:35 -0700
Message-Id: <1113344795.10420.125.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.797, required 12,
	autolearn=disabled, AWL 0.20, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 12.04.2005 Klokka 15:22 (-0400) skreiv Xin Zhao:
> I have very very fast network and is testing NFS2 over this kind of
> network. I noticed that for standard work like read/write a large
> file,  compile kernels, the performance of NFS2 is good. But if I try
> to decompress kernel tar file. The standard ext2 takes 28s while NFS2
> takes 81s. Also, if I remove the kernel source code tree, ext2 takes
> 19s but NFS2 takes 44s.
> 
> Why?  (You can assume that network is very fast. )  Is there any
> improvements in NFS3/4 on this issue? If so, how?

NFSv2 requires the server to immediately write all data to disk before
it can reply to the RPC write request (synchronous writes).

NFSv3 and v4 both have the ability to cache writes safely. The following
paper http://www.netapp.com/ftp/NFSv3_Rev_3.pdf has full details on how
and why.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

