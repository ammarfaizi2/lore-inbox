Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUEKGHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUEKGHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEKGHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:07:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:27881 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261718AbUEKGHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:07:47 -0400
Date: Tue, 11 May 2004 08:07:42 +0200 (MEST)
From: Armin Schindler <armin@melware.de>
To: Andre Ben Hamou <andre@bluetheta.com>
cc: Eric Dumazet <dada1@cosmosbay.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Multithread select() bug
In-Reply-To: <40A009D9.9090404@bluetheta.com>
Message-ID: <Pine.LNX.4.31.0405110759570.16956-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Andre Ben Hamou wrote:
> Eric Dumazet wrote:
> > So please how do you guarantee that thread 1 runs *before* thread 2)
> >
> > Thread 1)
> >        select( fd)
> >
> > Thread 2)
> >        close(fd)
> >
> > Thats not possible.
> >

Some time ago I sent a patch for the select() systemcall to return
if the last fd was closed. If select() specifies more than one fd, then
staying in select is valid, but if there is no more fd left to wait on,
select() should return I think. I don't know what standards say here
or other Unix do in that case, so I did't have a good reason for the patch
and it was ignored.
The patch was for 2.4, but 2.6 is the same and poll() as well.

Armin

