Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWFGRRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWFGRRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWFGRRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:17:20 -0400
Received: from pat.uio.no ([129.240.10.4]:48543 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932350AbWFGRRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:17:20 -0400
Subject: Re: [NFS] [PATCH] NFS server does not update mtime on
	setattr	request
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Neil Brown <neilb@suse.de>,
       NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4486F479.90406@redhat.com>
References: <4485C3FE.5070504@redhat.com>
	 <1149658707.27298.10.camel@localhost> <4486E662.5080900@redhat.com>
	 <20060607151754.GB23954@fieldses.org>  <4486F020.3030707@redhat.com>
	 <1149694742.26188.6.camel@localhost>  <4486F479.90406@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 13:17:03 -0400
Message-Id: <1149700624.26188.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.54, required 12,
	autolearn=disabled, AWL 1.46, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 11:44 -0400, Peter Staubach wrote:

> I am curious about how this would break truncate?

According to SuSv43, truncate should result in changes to
mtime/ctime/suid/sgid if and only if the file size changes. The
combination of disabling the client caching and always setting
mtime/ctime on the server will therefore clearly break truncate.

Cheers,
  Trond

