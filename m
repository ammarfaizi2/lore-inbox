Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWJMBaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWJMBaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 21:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWJMBaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 21:30:11 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:26131 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751445AbWJMBaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 21:30:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iRQKO7ry5e5bKE6jNAs5EiExnvy84vaufxmhHeXleLqOFQP1b8Qtg8yQiOawylUajS/M5ibtpzY7GByh7ojZ7dqMCesAzfccz2RKi4RZSp8ugJA317xAnICjGY/knYdNlsV/IKTZTATfRjH5GOieBjkfnspcWMd8KbiVN4V6xAs=
Message-ID: <4b3406f0610121830v7d53007ck92e1010bc36f26bf@mail.gmail.com>
Date: Fri, 13 Oct 2006 09:30:08 +0800
From: "Dongsheng Song" <dongsheng.song@gmail.com>
To: "Michael Poole" <mdpoole@troilus.org>
Subject: Re: maybe headers(linux/aio.h) bug ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87wt7567g9.fsf@graviton.dyn.troilus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4b3406f0610120527g42bfbc44q45b31dc07f5968de@mail.gmail.com>
	 <87wt7567g9.fsf@graviton.dyn.troilus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But the current C library's AIO support does not use Linux's AIO, if I
use Linux AIO, the only way is define my io_event, iocb, aio_context_t
types, isn't it ?


2006/10/12, Michael Poole <mdpoole@troilus.org>:
> Dongsheng Song writes:
>
> > Whenever I include linux aio header,  the compile errors occured:
> >
> > $  cat test.c
> > #include <linux/types.h>
> > #include <linux/unistd.h>
> > #include <linux/aio.h>
>
> Including kernel header files directly from userspace is not supported
> and is almost always (some just say "always") a very bad idea.  If you
> want to use the C library's AIO support, use its <aio.h> header.
>
> Michael Poole
>
