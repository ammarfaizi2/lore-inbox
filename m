Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUB2Vzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbUB2Vzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:55:49 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:4360 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262153AbUB2Vzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:55:49 -0500
Date: Sun, 29 Feb 2004 21:55:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       linux-kernel@vger.kernel.org
Subject: Re: [SELINUX] Handle fuse binary mount data.
Message-ID: <20040229215542.A31786@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
References: <Xine.LNX.4.44.0402291637360.22151-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Xine.LNX.4.44.0402291637360.22151-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Sun, Feb 29, 2004 at 04:38:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 04:38:51PM -0500, James Morris wrote:
>  	/* Ignore these fileystems with binary mount option data. */
> -	if (!strcmp(name, "coda") ||
> -	    !strcmp(name, "afs") || !strcmp(name, "smbfs"))
> +	if (!strcmp(name, "coda") || !strcmp(name, "afs") ||
> +	    !strcmp(name, "smbfs") || !strcmp(name, "fuse"))
>  		goto out;

Umm, binary mount data is bad enough, but hardcoding filesystem-depend code
in selinux is just bogus..

