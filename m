Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965390AbWHOQ2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965390AbWHOQ2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965392AbWHOQ2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:28:55 -0400
Received: from pat.uio.no ([129.240.10.4]:41351 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965387AbWHOQ2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:28:52 -0400
Subject: Re: [RHEL5 PATCH 2/2] NFS: Represent 64-bit fileids as 64-bit
	inode numbers on 32-bit systems [try #2]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@linux-nfs.org
In-Reply-To: <20060815152632.29222.66333.stgit@warthog.cambridge.redhat.com>
References: <20060815152627.29222.71414.stgit@warthog.cambridge.redhat.com>
	 <20060815152632.29222.66333.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 12:28:30 -0400
Message-Id: <1155659311.5657.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.085, required 12,
	autolearn=disabled, AWL 0.40, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 16:26 +0100, David Howells wrote:
>  
> -		/* We set i_ino for the few things that still rely on it,
> -		 * such as stat(2) */
> -		inode->i_ino = hash;
> +		/* We set i_ino for the few things that still rely on it, such
> +		 * as printing messages; stat and filldir use the fileid
> +		 * directly since i_ino may not be large enough */
> +		inode->i_ino = fattr->fileid;

Are there any plans to remove inode->i_ino? It would appear to have
outlived its usefulness.

Otherwise Acked...

Cheers,
  Trond

