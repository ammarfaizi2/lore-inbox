Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbTI3TAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTI3TAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:00:43 -0400
Received: from codepoet.org ([166.70.99.138]:32901 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S261676AbTI3TAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:00:40 -0400
Date: Tue, 30 Sep 2003 13:00:40 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930190039.GA5407@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andreas Steinmetz <ast@domdv.de>, Jens Axboe <axboe@suse.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F797316.2010401@domdv.de>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 30, 2003 at 02:12:06PM +0200, Andreas Steinmetz wrote:
> Jens Axboe wrote:
> >
> >I think I do.
> >
> >
> >>In order to use kernel interfaces you _need_ to include kernel include
> >>files.
> >
> >
> >False. You need to include the glibc kernel headers.
> >
> Then please tell me why PPPIOCNEWUNIT is only defined in linux/if_ppp.h 
> and not net/if_ppp.h which is still true for glibc-2.3.2. And please 
> don't tell me to ask the glibc folks. There are inconsistencies between 
> kernel headers and userland headers which force the inclusion of kernel 
> headers in userland applications.

Wrong.  Userland applications should make private copies of all
needed kernel defines and structures, and then change any kernel
types to use standard C99 types from stdint.h.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
