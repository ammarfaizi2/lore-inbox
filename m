Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTFDL5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 07:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTFDL5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 07:57:46 -0400
Received: from ns.suse.de ([213.95.15.193]:37903 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263264AbTFDL5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 07:57:45 -0400
Date: Wed, 4 Jun 2003 14:09:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Message-ID: <20030604120932.GS3412@x30.school.suse.de>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au> <20030604120053.GQ4853@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604120053.GQ4853@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 02:00:53PM +0200, Jens Axboe wrote:
> since you have a single writer and maybe a reader or two. The single
> writer cannot starve anyone else.

unless you're changing an atime and you've to mark_buffer_dirty or
similar (balance_dirty will write stuff the same way from cp and the
reader then).

Maybe we can get some stack trace with kgdb to be sure where the reader
is blocking.

Andrea
