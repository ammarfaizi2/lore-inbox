Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVD2IFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVD2IFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 04:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVD2IFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 04:05:07 -0400
Received: from smtp.istop.com ([66.11.167.126]:57037 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262460AbVD2IEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 04:04:47 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1a/7] dlm: core locking
Date: Fri, 29 Apr 2005 04:05:28 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20050425165705.GA11938@redhat.com> <200504272241.04254.phillips@istop.com> <20050428122147.GO21645@marowsky-bree.de>
In-Reply-To: <20050428122147.GO21645@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290405.29082.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 08:21, Lars Marowsky-Bree wrote:
> On 2005-04-27T22:41:04, Daniel Phillips <phillips@istop.com> wrote:
> > > Just a couple comments here, more will come as time permits. I know you
> > > consider cluster file systems to be "obscure" apps...
> >
> > Oh the contrary, cluster filesystems are the main focus of and reason for
> > the current submission.
>
> He was actually quoting David. And indeed it is very important that the
> DLM interfaces be generally useful, not just for a specific cluster
> filesystem; if that was the goal, it would be an internal component only
> and no need to expose it.

True, sort of.  Remember, the _only_ argument for (g)dlm being in-kernel is to 
tighten up the interface for filesystems.  If (g)dlm could be trimmed down by 
supporting _only_ in-kernel filesystems, with a different, userspace lock 
manager for user space apps, well, that is a strategy that has to be 
considered.

Taking part of (g)dlm out of kernel is also something that needs to be looked 
it.  It is a little on the biggish side.

Don't forget, (g)dlm is just a cluster service, and at present, a service that 
has exactly one user in the whole world: gfs.  We'd like to attract more, but 
not at the cost of kernel bloat.

Regards,

Daniel
