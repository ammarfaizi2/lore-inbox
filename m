Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVJDRxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVJDRxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVJDRxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:53:07 -0400
Received: from xenotime.net ([66.160.160.81]:48549 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964865AbVJDRxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:53:06 -0400
Date: Tue, 4 Oct 2005 10:53:02 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 in-kernel file opening
In-Reply-To: <Pine.LNX.4.60.0510041940070.8210@kepler.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.58.0510041052200.17335@shark.he.net>
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
 <Pine.LNX.4.60.0510041933310.8210@kepler.fjfi.cvut.cz>
 <Pine.LNX.4.60.0510041940070.8210@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, Martin Drab wrote:

> On Tue, 4 Oct 2005, Martin Drab wrote:
>
> > On Tue, 4 Oct 2005, Martin Drab wrote:
> >
> > > Hi,
> > >
> > > can anybody tell me why there is no sys_open() exported in kernel/ksyms.c
> > > in 2.4 kernels while the sys_close() is there? And what is then the
> > > preferred way of opening files from within a 2.4 kernel module?
> >
> > Is it just pure filp_open()/filp_close() ?
>
> Now I see sys_open() is doing a strncpy_from_user() conversion, so that's
> why it's not good for in-kernel use. So I assume the
> filp_open()/filp_close() is OK then.

Still, there is no "preferred" way of opening files from
within the kernel.  Do it in userspace.

-- 
~Randy
