Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbVKDMTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbVKDMTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbVKDMTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:19:52 -0500
Received: from mail.suse.de ([195.135.220.2]:20669 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932729AbVKDMTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:19:52 -0500
Date: Fri, 4 Nov 2005 13:20:21 +0100
From: jblunck@suse.de
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104122021.GA15061@hasse.suse.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051104115101.GH7992@ftp.linux.org.uk>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, Al Viro wrote:

> > 
> > SuSV3 only says:
> > "If a file is removed from or added to the directory after the most recent
> > call to opendir() or rewinddir(), whether a subsequent call to readdir_r()
> > returns an entry for that file is unspecified."
>  
> IOW, the applications in question are broken since they rely on unspecified
> behaviour, not provided by old libc versions.

No. SuSV3 only says that the behavior of readdir() is unspecified w.r.t. an
entry for the removed/added file. I think readdir() should still return the
entries which are not removed/added. What do you think?

Regards,
	Jan Blunck

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
