Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVGLWsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVGLWsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVGLWpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:45:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60425 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261828AbVGLWn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:43:56 -0400
Date: Wed, 13 Jul 2005 00:43:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: [2.6 patch] fs/jbd/: possible cleanups
Message-ID: <20050712224353.GN4034@stusta.de>
References: <20050712202742.GM4034@stusta.de> <20050712223243.GW5335@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712223243.GW5335@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 04:32:44PM -0600, Andreas Dilger wrote:
> On Jul 12, 2005  22:27 +0200, Adrian Bunk wrote:
>...
> > - journal.c: remove the unused global function __journal_internal_check
> >              and move the check to journal_init
> 
> I don't mind removing this function, but it shouldn't be put inside #ifdef
> JBD_DEBUG, as that would remove the check from the compiler-parsed code
> and defeat the purpose of the check.

???

That's not what my patch is doing.

journal_init() is not inside an #ifdef JBD_DEBUG.

>...
> > - remove the following unneeded EXPORT_SYMBOL's:
> >   - journal.c: journal_check_used_features
> 
> Should be kept for API completeness.
>...

The function itself isn't removed.

Does it really has to stay exported or isn't it enough to re-export it 
when a user appears?

> Cheers, Andreas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

