Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVESN0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVESN0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVESN0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:26:52 -0400
Received: from pat.uio.no ([129.240.130.16]:9392 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262490AbVESN0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:26:45 -0400
Subject: Re: why nfs server delay 10ms in nfsd_write()?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: Lee Revell <rlrevell@joe-job.com>, steve <lingxiang@huawei.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
In-Reply-To: <428C8C32.2030803@redhat.com>
References: <0IGP00IZRULADZ@szxml02-in.huawei.com>
	 <1116472423.11327.1.camel@mindpipe>  <428C8C32.2030803@redhat.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 09:26:06 -0400
Message-Id: <1116509166.10911.41.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.624, required 12,
	autolearn=disabled, AWL 1.33, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 19.05.2005 Klokka 08:53 (-0400) skreiv Peter Staubach:
> There are certainly many others way to get gathering, without adding an
> artificial delay.  There are already delay slots built into the code 
> which could
> be used to trigger the gathering, so with a little bit different 
> architecture, the
> performance increases could be achieved.
> 
> Some implementations actually do write gathering with NFSv3, even.  Is
> this interesting enough to play with?  I suspect that just doing the 
> work for
> NFSv2 is not...

Write gathering does still apply to stable NFSv3/v4 writes, so an
optimisation may yet benefit applications that use O_DIRECT writes, or
that require the use of the "noac" or "sync" mount options.

I'm not aware of any ongoing projects to work on this, though, so it
would probably be up to those parties that see it as beneficial to step
up to the plate.

Cheers,
  Trond

