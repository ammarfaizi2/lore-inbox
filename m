Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVLGOLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVLGOLi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVLGOLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:11:37 -0500
Received: from pat.uio.no ([129.240.130.16]:40090 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751072AbVLGOLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:11:37 -0500
Subject: Re: another nfs puzzle
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4396EB2F.3060404@redhat.com>
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
	 <4396EB2F.3060404@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 09:11:07 -0500
Message-Id: <1133964667.27373.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.977, required 12,
	autolearn=disabled, AWL 1.84, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 09:01 -0500, Peter Staubach wrote:
> Kenny Simpson wrote:
> 
> >Hi again,
> >  I am seeing some odd behavior with O_DIRECT.  If a file opened with O_DIRECT has a page mmap'd,
> >and the file is extended via pwrite, then the mmap'd region seems to get lost - i.e. it neither
> >takes up system memory, nor does it get written out.
> >  
> >
> 
> I don't think that I understand why or how the kernel allows a file,
> which was opened with O_DIRECT, to be mmap'd.  The use of O_DIRECT
> implies no caching and mmap implies the use of caching.

In this context it doesn't matter whether or not the you use the same
file descriptor. The problem is the same if my process opens the file
for O_DIRECT and then your process open it for normal I/O, and mmaps it.

Cheers,
  Trond

