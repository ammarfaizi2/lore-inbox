Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWDSPvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDSPvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWDSPvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:51:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:2212 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750808AbWDSPvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:51:07 -0400
Date: Wed, 19 Apr 2006 08:44:19 -0700
From: Greg KH <greg@kroah.com>
To: Yuichi Nakamura <ynakam@gwu.edu>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kurt Garloff <garloff@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Gerrit Huizenga <gh@us.ibm.com>,
       James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060419154419.GB26635@kroah.com>
References: <20060417225525.GA17463@infradead.org> <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com> <20060418115819.GB8591@infradead.org> <20060418213833.GC5741@tpkurt.garloff.de> <20060419121034.GE20481@sergelap.austin.ibm.com> <e133c9da8fcba.8fcbae133c9da@gwu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e133c9da8fcba.8fcbae133c9da@gwu.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 08:55:56AM -0400, Yuichi Nakamura wrote:
> However, path-name based configuration can not be achieved on SELinux in
> following cases.
> 1) Files on file system that does not support xattr(such as sysfs)
>    SELinux policy editor handles all files as same on such file systems.

Hm, I've thought about this in the past and wonder if we should add
xattr support to sysfs.  Would it be useful for things like SELinux?
The files would not be created with any xattrs, but would be able to
have them once they are set.  Would that be good enough?

thanks,

greg k-h
