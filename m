Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946492AbWJSVAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946492AbWJSVAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946495AbWJSVAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:00:41 -0400
Received: from mx2.netapp.com ([216.240.18.37]:46225 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946492AbWJSVAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:00:40 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419667660:sNHT17298640"
Subject: Re: [PATCH 1/2] VFS: Make d_materialise_unique() enforce directory
	uniqueness
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
In-Reply-To: <E1GaerI-0007Af-00@dorka.pomaz.szeredi.hu>
References: <20061019171113.8593.8585.stgit@lade.trondhjem.org>
	 <E1GaerI-0007Af-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Thu, 19 Oct 2006 17:00:38 -0400
Message-Id: <1161291638.5506.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 21:00:39.0621 (UTC) FILETIME=[A1D8B750:01C6F3C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 22:51 +0200, Miklos Szeredi wrote:
> > From: Trond Myklebust <Trond.Myklebust@netapp.com>
> > 
> > If the caller tries to instantiate a directory using an inode that already
> > has a dentry alias, then we attempt to rename the existing dentry instead
> > of instantiating a new one. Fail with an ELOOP error if the rename would
> > affect one of our parent directories.
> > 
> > This behaviour is needed in order to avoid issues such as
> > 
> >   http://bugzilla.kernel.org/show_bug.cgi?id=7178
> >
> 
> This looks like a stale patch.  You posted one on -fsdevel that did
> i_mutex locking as well.

Argh! Thanks for spotting that Miklos... I had forgotten to update my
'fixes' stgit branch with the newer version. Please discard the previous
version of this patch, Linus. I'll resend...

Cheers,
  Trond
