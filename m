Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWCTMxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWCTMxm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWCTMxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:53:41 -0500
Received: from mail1.kontent.de ([81.88.34.36]:14291 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932270AbWCTMxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:53:41 -0500
From: Oliver Neukum <oliver@neukum.org>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
Date: Mon, 20 Mar 2006 13:52:52 +0100
User-Agent: KMail/1.8
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Matthew Wilcox" <matthew@wil.cx>, viro@zeniv.linux.org.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de> <200603192150.23444.oliver@neukum.org> <84144f020603192325h54fd3212l1f4846fd40b9f074@mail.gmail.com>
In-Reply-To: <84144f020603192325h54fd3212l1f4846fd40b9f074@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603201352.56288.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Rewriting the test as:
> > n!=0 && n > INT_MAX / size
> > saves the division because size is much likelier to be a constant, and indeed
> > the code is better:
> >
> >         cmpq    $268435455, %rax
> >         movq    $0, 40(%rsp)
> >         ja      .L313
> >
> > Is there anything I am missing?
> 
> Did you check allyesconfig vmlinux size before and after? If it helps,
> like it probably does, post a patch!

Hi Pekka,

it saves 18K of 232M. I am making a patch.

	Regards
		Oliver
