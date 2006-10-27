Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWJ0Py4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWJ0Py4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWJ0Py4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:54:56 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:2988 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750972AbWJ0Py4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:54:56 -0400
Date: Fri, 27 Oct 2006 11:54:03 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: David Howells <dhowells@redhat.com>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching
Message-ID: <20061027155402.GA6717@filer.fsl.cs.sunysb.edu>
References: <20061025202155.GB3854@filer.fsl.cs.sunysb.edu> <16969.1161771256@redhat.com> <7864.1161856568@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7864.1161856568@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 10:56:08AM +0100, David Howells wrote:
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
...
> > I'm wondering, why don't just you duplicate all the attributes of the files
> > (including xattrs)? That would take care of most if not all the DAC/MAC
> > issues, no?
> 
> You're forgetting that the userspace cache manager daemon still has to access
> the cache.

Yeah, I did forget. Since there is a userspace daemon, it sounds like what
you're doing is right.

> > I'm thinking that it would be nice to combine the caching related security
> > code with those for stackable filesystems.
> 
> That's fine by me, though I want the security on a cache file to be different
> to that on the netfs file it's backing.

It sounds reasonable, and my guess is that chances are that the two
(stackable fs and caching) don't really overlap too much.

Josef "Jeff" Sipek.

-- 
UNIX is user-friendly ... it's just selective about who it's friends are
