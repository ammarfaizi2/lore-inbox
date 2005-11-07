Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVKGKQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVKGKQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVKGKQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:16:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:22187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964813AbVKGKQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:16:32 -0500
Date: Mon, 7 Nov 2005 11:17:10 +0100
From: jblunck@suse.de
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051107101710.GB7932@hasse.suse.de>
References: <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de> <E1EY3Y8-0004XX-00@dorka.pomaz.szeredi.hu> <20051104154610.GB23962@hasse.suse.de> <E1EY3uI-0004cC-00@dorka.pomaz.szeredi.hu> <20051104160443.GB25491@hasse.suse.de> <E1EY4Hp-0004hf-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1EY4Hp-0004hf-00@dorka.pomaz.szeredi.hu>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, Miklos Szeredi wrote:

> 
> Your patch is not a solution, since readdir will remain nonconforming.
> It is basically a workaround for a bug in glibc.

Updating the glibc is no solution because this isn't possible here. And I still
have the opinion that it is the filesystems job to remember the right
offset. At least this is what SuSV3 is telling me.

> It makes readdir
> nonconforming in a different way, but the end result in not
> necessarily better.

Hmm, yes you are right. 

> 
> If you manage to make dcache_readdir conform to SUS without overly
> bloating the implementation, that's fine.

Will look into that, if its possible.

Regards,
	Jan Blunck

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
