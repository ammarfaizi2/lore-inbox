Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTD1BnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTD1BnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:43:21 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:41371 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263527AbTD1BnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:43:20 -0400
Date: Sun, 27 Apr 2003 18:55:30 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: Chris Wright <chris@wirex.com>
Subject: Re: [CHECKER] 30 potential dereference of user-pointer errors
In-Reply-To: <Mutt.LNX.4.44.0304271925350.870-100000@excalibur.intercode.com.au>
Message-ID: <Pine.GSO.4.44.0304271853110.12242-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

sorry the net/ipv4 warning is a false posiglve. i just checked this
warning again. CMSG_DATA(cmsg) is passed into ip_options_get with param
"user" == 0.  our checker didn't figure out that "user" == 0 implied that
the CMSG_DATA(cmsg)  was a kernel pointer.

-Junfeng


On Sun, 27 Apr 2003, James Morris wrote:

> On Fri, 25 Apr 2003, Junfeng Yang wrote:
>
> > Where bugs occur:
> >
> > net/ipv4/ip_sockglue.c
>
> Which kernel version is this for?
>
>
> - James
> --
> James Morris
> <jmorris@intercode.com.au>
>

