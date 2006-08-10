Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWHJRi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWHJRi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWHJRi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:38:57 -0400
Received: from pat.uio.no ([129.240.10.4]:13999 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422650AbWHJRi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:38:56 -0400
Subject: Re: Urgent help needed on an NFS question, please help!!!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Neil Brown <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140608101008t4e9a4451r8d1a7bd3c49c4f8b@mail.gmail.com>
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
	 <17626.52269.828274.831029@cse.unsw.edu.au>
	 <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
	 <20060810161107.GC4379@parisc-linux.org>
	 <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
	 <20060810165431.GD4379@parisc-linux.org>
	 <4ae3c140608101008t4e9a4451r8d1a7bd3c49c4f8b@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 13:38:40 -0400
Message-Id: <1155231520.10547.68.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.072, required 12,
	autolearn=disabled, AWL -0.78, NIGERIAN_SUBJECT2 1.76,
	PLING_PLING 0.43, RCVD_IN_XBL 2.51, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 13:08 -0400, Xin Zhao wrote:
> Well. For regular NFS, because it needs to consider interoperability,
> it cannot use file handle as an opaque object.
> 
> However, in our case, we essentially derived a VM based data sharing
> infrastructure from NFS. This would allow multiple virtual machines in
> a single server to share data efficiently. With some tricks, we are
> able to export inode cache from server to client. Also, we modify the
> file handle composer to carry the server-side inode address, inode
> number, i_gen, dev along with a file handle. Upon receiving a file
> handle, a client can directly access the inode object in the exported
> inode cache and bypass the inter-VM communication.

The correct way to do this sort of thing is to use pNFS, which has
protocol support for this sort of thing, and is part of the draft NFSv4
minor version 1 specification. See

   http://www.ietf.org/internet-drafts/draft-ietf-nfsv4-minorversion1-04.txt

Cheers,
  Trond

