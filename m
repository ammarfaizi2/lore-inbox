Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315130AbSENCtQ>; Mon, 13 May 2002 22:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315133AbSENCtP>; Mon, 13 May 2002 22:49:15 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:52982 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S315130AbSENCtP>;
	Mon, 13 May 2002 22:49:15 -0400
Date: Mon, 13 May 2002 22:49:08 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.1[345]-dj Add cpqarray_init() back into genhd.c
Message-ID: <20020514024908.GA7695@www.kroptech.com>
In-Reply-To: <20020514020334.GA24417@www.kroptech.com> <6422.1021343063@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 12:24:23PM +1000, Keith Owens wrote:
> On Mon, 13 May 2002 22:03:34 -0400, 
> Adam Kropelin <akropel1@rochester.rr.com> wrote:
> >In 2.5.13-dj1, the call to cpqarray_init() in drivers/block/genhd.c was
> >dropped. I'm not sure what the intent was since the driver seems to work fine

<snip>

> The real problem appears to be cpqarray.c, it wraps the init/exit code
> in #ifdef MODULE, so the init code is only available to modules.  I
> think that cpqarray.c should remove the #ifdef MODULE and use the same
> init mechanism as other drivers, including module_init/exit.  I don't
> have a card and the code is a mess so I am not going to attempt a patch.

I'm not seeing it. I see init_module() and cleanup_module() wrapped as you say
but cpqarray_init() is outside the #ifdef. Also, two versions of cpqarray_setup
are provided based on #ifdef MODULE but this doesn't look problematic to me.
I'm a newbie, for sure. Am I overlooking something obvious?

--Adam

