Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273870AbRI1JvH>; Fri, 28 Sep 2001 05:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275994AbRI1Ju5>; Fri, 28 Sep 2001 05:50:57 -0400
Received: from mail.zmailer.org ([194.252.70.162]:12549 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S273870AbRI1Jun>;
	Fri, 28 Sep 2001 05:50:43 -0400
Date: Fri, 28 Sep 2001 12:51:00 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bobby Hitt <bobhitt@bscnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2GB File limitation
Message-ID: <20010928125100.B1144@mea-ext.zmailer.org>
In-Reply-To: <013801c147e5$3330bec0$092cdb3f@bobathome> <Pine.LNX.4.33.0109281011010.2517-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109281011010.2517-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Sep 28, 2001 at 10:13:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 10:13:09AM +0200, Ingo Molnar wrote:
> On Fri, 28 Sep 2001, Bobby Hitt wrote:
> > Is someone working on a way to overcome the 2GB file limitation in
> > Linux? I currently backup several servers using a dedicated hard drive
> > for the backups. Recently I saw one backup die saying the the file
> > size had been exceeded. I've never had good luck with tape backups,
> > yes they backup, but whenever I really need a file, it can't be
> > retrieved.
> 
> file sizes up to ~ 2 TB are supported under the 2.4 kernel. (or 2.2 kernel
> + patches) Most utilities are updated to use O_LARGEFILE properly, in any
> recent 2.4-based Linux distribution. I regularly use 6-10 GB files.

  Like Ingo says, most of modern distributions begin to work with
  O_LARGEFILE  properly, but still some utilities fail it.

  Your older backup application program may fail it too.

  The solution could be as simple as piping the backup material
  into another program, which then pipes it out, e.g.:
	'|dd bs=1M of=/backups/fileNNN'

> 	Ingo

/Matti Aarnio
