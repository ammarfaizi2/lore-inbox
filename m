Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVJFRZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVJFRZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVJFRZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:25:53 -0400
Received: from pat.uio.no ([129.240.130.16]:43909 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751246AbVJFRZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:25:52 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 13:25:26 -0400
Message-Id: <1128619526.16534.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.929, required 12,
	autolearn=disabled, AWL 1.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 06.10.2005 Klokka 19:06 (+0200) skreiv Miklos Szeredi:
> > The reason why we do it as a lookup intent is because this has to be
> > atomic lookup+create+open in order to be at all useful to NFS.
> 
> Oh, and btw there's a problem with atomic lookup+create+open: mounts.
> Do you want to follow mounts inside ->lookup().  Ugly.

No. Why do you think you would need to? The VFS is supposed to protect
you against races with mount and other local objects (dcache races,
inode races,...). The problem is remote objects.

Cheers,
  Trond


