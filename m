Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbSA1LIe>; Mon, 28 Jan 2002 06:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbSA1LIY>; Mon, 28 Jan 2002 06:08:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21775 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286712AbSA1LIL>;
	Mon, 28 Jan 2002 06:08:11 -0500
Date: Mon, 28 Jan 2002 12:07:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        John Levon <movement@marcelothewonderpenguin.com>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
Message-ID: <20020128120747.A837@suse.de>
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com> <20020125204911.A17190@wotan.suse.de> <20020125133814.U763@lynx.adilger.int> <20020125231555.A22583@wotan.suse.de> <3C54871E.80621B4E@oracle.com> <20020128010142.A23952@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020128010142.A23952@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28 2002, Andi Kleen wrote:
> On Mon, Jan 28, 2002 at 12:02:54AM +0100, Alessandro Suardi wrote:
> > 
> > 2.5.3-pre5 + this patch still can't boot my system. I haven't had
> >  time to copy down oops at boot, will do if needed.
> 
> Please do. I cannot see anything in the patch that should prevent bootup
> though, so I would also recommend a make clean and recompile first just
> to make sure it isn't a broken build. 

Probably the kmem_cache_create 'name too long' bug that Viro pointed out
to me. fs/reiserfs/super.c:init_inodecache(). Change the name passed to
kmem_cache_create to something shorter.

-- 
Jens Axboe

