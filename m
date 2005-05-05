Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVEEXeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVEEXeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 19:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVEEXeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 19:34:44 -0400
Received: from groover.houseafrikarecords.com ([12.162.17.52]:7992 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261935AbVEEXek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 19:34:40 -0400
Date: Thu, 5 May 2005 16:34:39 -0700
From: Libor Michalek <libor@topspin.com>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050505163439.A26428@topspin.com>
References: <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> <4279142A.8050501@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4279142A.8050501@ammasso.com>; from timur.tabi@ammasso.com on Wed, May 04, 2005 at 01:27:54PM -0500
X-OriginalArrivalTime: 05 May 2005 23:34:39.0359 (UTC) FILETIME=[0165D8F0:01C551CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 01:27:54PM -0500, Timur Tabi wrote:
> Libor Michalek wrote:
> 
> >   The program opens the charcter device file descriptor, pins the pages
> > and waits for a signal, before checking the pages, which is sent to the
> > process after running some other program which exercises the VM. On older
> > kernels the check fails, on my 2.6.11 kernel the check succeeds. So
> > mlock is not needed on top of get_user_pages() as it was before.
> 
> When you say "older", what exactly do you mean? I have different test 
> that normally fails with just get_user_pages(), but it works with 2.6.9
> and above.  I haven't been able to get any kernel earlier than 2.6.9 to
> compile or boot properly, so I'm having a hard time narrowing down the
> actual point when get_user_pages() started working.

  The older kernel I tried was one of the 2.4.21 RHEL 3 kernels. I hadn't
spent much time investigating the issue since this was a new kernel, so it
was a natural one for me to try.

-Libor
