Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTKJNX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTKJNX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:23:57 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:64748 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263485AbTKJNX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:23:56 -0500
Subject: Re: [PATCH] cfq + io priorities
From: Albert Cahalan <albert@users.sf.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1AJ994-0002xM-00@gondolin.me.apana.org.au>
References: <E1AJ994-0002xM-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Organization: 
Message-Id: <1068469674.734.80.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 08:07:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 05:19, Herbert Xu wrote:
> Albert Cahalan <albert@users.sf.net> wrote:
> > 
> > Sure, but do it in a way that's friendly to
> > all the apps and admins that only know "nice".
> > 
> > nice_cpu   sets CPU niceness
> > nice_net   sets net niceness
> > nice_disk  sets disk niceness
> > ...
> > nice       sets all niceness values at once
> 
> That's a user space problem.  No matter what Jens
> does, you can always make nice(1) do what you said.

It's not just the nice command. There's a syscall
interface you know, and lots of apps use it.

#include <unistd.h>
int nice(int inc);

You planning to hack ALL those apps? You'll
convince BSD-centric developers to include
this Linux-specific change?

Besides, the kernel load average was changed to
include processes waiting for IO. It just plain
makes sense to mix CPU usage with IO usage by
default. Wanting different niceness for CPU
and IO is a really unusual thing.


