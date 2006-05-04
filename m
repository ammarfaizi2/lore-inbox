Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWEDRuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWEDRuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 13:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWEDRuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 13:50:44 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:43203 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030254AbWEDRun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 13:50:43 -0400
Date: Thu, 4 May 2006 10:50:43 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: limits / PIPE_BUF?
In-Reply-To: <1146762968.3101.65.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0605041044270.30003@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net> 
 <1146725882.3101.11.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0605040938310.19371@shell3.speakeasy.net>
 <1146762968.3101.65.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006, Arjan van de Ven wrote:

> On Thu, 2006-05-04 at 09:39 -0700, Vadim Lobanov wrote:
> > How does the kernel
> > code ensure that this value is honored, considering that PIPE_BUF is
> > not
> > referenced in any of the pipe code?
>
>
> the kernel implementation guarantees one page basically, and on all
> architectures that I know of that's at least 4096 bytes
>

Alright, so sounds like this constant should remain inside the
include/linux/limits.h file. What about #defining it to be equal to
PAGE_SIZE, like ARM (include/linux-arm/limits.h, for example) does?

- Vadim Lobanov
