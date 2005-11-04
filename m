Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbVKDQEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbVKDQEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbVKDQEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:04:14 -0500
Received: from ns.suse.de ([195.135.220.2]:47329 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161157AbVKDQEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:04:13 -0500
Date: Fri, 4 Nov 2005 17:04:43 +0100
From: jblunck@suse.de
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jblunck@suse.de, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104160443.GB25491@hasse.suse.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de> <E1EY3Y8-0004XX-00@dorka.pomaz.szeredi.hu> <20051104154610.GB23962@hasse.suse.de> <E1EY3uI-0004cC-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1EY3uI-0004cC-00@dorka.pomaz.szeredi.hu>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, Miklos Szeredi wrote:

> > > > 
> > > > Well, glibc is that stupid and triggers the bug.
> > > 
> > > Seems to me, the simple solution is to upgrade your glibc.
> > > 
> > 
> > This is SLES8. You don't want to update the glibc.
> 
> OK, but then it's basically a SLES8 kernel issue, not a mainline
> kernel issue.
> 
> Probably very few people are using brand new kernels with glibc from
> the last millennium ;)
> 

Hmm, so I should only send patches for bugs that are often triggered
upstream? Just start using seekdir() and modify the directory contents on an
upstream tmpfs. You'll see that this isn't working well.

This is a bug and it should get fixed. I hope that it doesn't depend on how
many people using what library :)

Regards,
	Jan Blunck

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
