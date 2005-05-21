Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVEUJKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVEUJKP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVEUJKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 05:10:15 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:61959 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261471AbVEUJKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 05:10:08 -0400
To: linuxram@us.ibm.com
CC: miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jamie@shareable.org
In-reply-to: <1116665101.4397.71.camel@localhost> (message from Ram on Sat, 21
	May 2005 01:45:01 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <1116665101.4397.71.camel@localhost>
Message-Id: <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 21 May 2005 11:09:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I still see a problem: what if old_nd.mnt is already detached, and
> > bind is non-recursive.  Now it fails with EINVAL, though it used to
> > work (and I think is very useful).
> 
> I am not getting this comment.  R u assuming that a detached mount
> will have NULL namespace?

Yes.

> If so I dont see it being the case.

See this patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111627383207049&w=2

Miklos

