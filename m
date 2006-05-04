Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWEDQjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWEDQjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWEDQjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:39:55 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:58559 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030214AbWEDQjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:39:54 -0400
Date: Thu, 4 May 2006 09:39:53 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: limits / PIPE_BUF?
In-Reply-To: <1146725882.3101.11.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0605040938310.19371@shell3.speakeasy.net>
References: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net>
 <1146725882.3101.11.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006, Arjan van de Ven wrote:

> On Wed, 2006-05-03 at 22:55 -0700, Vadim Lobanov wrote:
> > A snippet from include/linux/limits.h:
> > #define PIPE_BUF        4096    /* # bytes in atomic write to a pipe */
> >
> > PIPE_BUF is a bit of an oddity. It is defined there, then redefined in
> > the arm header files, even though those header files are never included
> > anywhere. Also, PIPE_BUF is never referenced by name in any of the Linux
> > code. And yet, it is still being mentioned in some Big And Scary
> > Warnings (tm): fs/autofs4/waitq.c or include/linux/pipe_fs_i.h, for
> > example.
>
> it's for userland to tell it what the size of the atomic pipe operations
> we can do is.
>

How does userland get this value from the kernel? How does the kernel
code ensure that this value is honored, considering that PIPE_BUF is not
referenced in any of the pipe code?

- Vadim Lobanov
