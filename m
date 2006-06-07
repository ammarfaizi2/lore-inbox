Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWFGPSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWFGPSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWFGPSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:18:08 -0400
Received: from mail.fieldses.org ([66.93.2.214]:27795 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932253AbWFGPSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:18:07 -0400
Date: Wed, 7 Jun 2006 11:17:54 -0400
To: Peter Staubach <staubach@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Neil Brown <neilb@suse.de>,
       NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] NFS server does not update mtime on setattr request
Message-ID: <20060607151754.GB23954@fieldses.org>
References: <4485C3FE.5070504@redhat.com> <1149658707.27298.10.camel@localhost> <4486E662.5080900@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4486E662.5080900@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 10:44:50AM -0400, Peter Staubach wrote:
> I saw that wording too and assumed what I think that you assumed.  I
> assumed that that meant that if the new size is equal to the old size,
> then nothing should be changed.  However, that does not seem to be how
> those words are to be interpreted.  They are to be interpreted as "if
> the new length of the file can be successfully set, then the
> mtime/ctime should be changed".

What's the basis for that interpretation?  The language seems extremely
clear:

	"On successful completion, if the file size is changed, these
	functions will mark for update the st_ctime and st_mtime fields
	of the file, and if the file is a regular file, the S_ISUID and
	S_ISGID bits of the file mode may be cleared."

Why are you concerned about this?  Do you have an actual application
that breaks?

--b.
