Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSEGWMi>; Tue, 7 May 2002 18:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSEGWMh>; Tue, 7 May 2002 18:12:37 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:39865 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S314546AbSEGWMf>;
	Tue, 7 May 2002 18:12:35 -0400
Date: Wed, 8 May 2002 00:12:32 +0200
From: David Weinehall <tao@acc.umu.se>
To: Thunder from the hill <thunder@ngforever.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Possible SCSI (sr) mini-cleanup
Message-ID: <20020508001232.I9980@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.44.0205071445480.4189-100000@hawkeye.luckynet.adm> <20020507220235.GB27824@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 04:02:35PM -0600, Andreas Dilger wrote:
> On May 07, 2002  14:50 -0600, Thunder from the hill wrote:
> > I don't see where the variable and the label have been used. Are they 
> > useful for anything? If they are, tell me please!
> 
> > @@ -723,8 +721,6 @@
> >  		goto cleanup_cds;
> >  	memset(sr_sizes, 0, sr_template.dev_max * sizeof(int));
> >  	return 0;
> > -cleanup_sizes:
> > -	kfree(sr_sizes);
> >  cleanup_cds:
> >  	kfree(scsi_CDs);
> >  cleanup_devfs:
> 
> Note that you are also removing the "kfree(sr_sizes)" which is
> definitely used...

There's a return 0 on the line before the kfree(sr_sizes);,
so either there is a goto cleanup_sizes somewhere, or the code is dead.

Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
