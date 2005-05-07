Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVEGRgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVEGRgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 13:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVEGRgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 13:36:25 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:44924 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262727AbVEGRgW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 13:36:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NE2xTQyU6HliMDx9VrgXyg6NNXAvAizdEjHuyZNLPkz6kDiO198YKFJQVn9le+I3CnRZXDbyWH8EcTWsewrQmNe5HoHLAp7iNelHC74X1AB/z6ewgR7F6/S0YFZtk7sQNSYVbZMcqMFW7/vLrT6aJU+gMVVRC73J0w8Ry2kRCrE=
Message-ID: <92df3175050507103621a88554@mail.gmail.com>
Date: Sat, 7 May 2005 13:36:21 -0400
From: Yuly Finkelberg <liquidicecube@gmail.com>
Reply-To: Yuly Finkelberg <liquidicecube@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Scheduler: Spinning until tasks are STOPPED
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <427C6A5C.6090900@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <92df3175050506233110a19a60@mail.gmail.com>
	 <427C6A5C.6090900@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

> You're doing this in the *kernel*? It sounds like it should be done
> in userspace or done a different way (ie. not with 50 tasks).

These are tasks that are running in the kernel on behalf of a new system call.  

> And using signals and spinning on yield for synchronisation and
> process control in the kernel like this is fairly crazy.

The problem appears to be not with the process that is
spinning/yielding, but rather the one process which gets stuck.  It is
charged almost all the system time.  I agree that it's not pretty
though...

> Can't you use a semaphore or something?

There is noone to call up() when a process is actually stopped.

If you have any ideas as to what can be happening or a better way to
accomplish this (in the kernel), I'd appreciate hearing it.
