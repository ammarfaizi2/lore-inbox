Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132568AbRDULqi>; Sat, 21 Apr 2001 07:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRDULq3>; Sat, 21 Apr 2001 07:46:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41991 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132567AbRDULqN>;
	Sat, 21 Apr 2001 07:46:13 -0400
Date: Sat, 21 Apr 2001 13:45:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@image.dk>
Subject: Re: cdrom driver dependency problem (and a workaround patch)
Message-ID: <20010421134554.E26732@suse.de>
In-Reply-To: <Pine.LNX.4.32.0104210107160.1148-100000@callisto.yi.org> <20010421134412.O682@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010421134412.O682@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Sat, Apr 21, 2001 at 01:44:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21 2001, Ingo Oeser wrote:
> On Sat, Apr 21, 2001 at 02:17:18AM +0300, Dan Aloni wrote:
> > One reason for this misdependency is that the IDE is initialized before
> > the cdrom driver, register_cdrom() gets called from inside the IDE
> > initialization functions. (ide_init() -> ide_init_builtin_drivers() ->
> > ide_cdrom_init() -> ide_cdrom_setup() -> ide_cdrom_register() ->
> > register_cdrom())
> > 
> > In order to get my kernel to boot, I've made the following temporary
> > workaround patch. I'd be glad to hear about other ways of solving this.
> 
> The link order is wrong. So why not changing the link order then?

That's perfect, I just hadn't looked into that. The superior solution,
clearly, thanks!

-- 
Jens Axboe

