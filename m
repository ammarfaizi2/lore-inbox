Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbSL3WYk>; Mon, 30 Dec 2002 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbSL3WYk>; Mon, 30 Dec 2002 17:24:40 -0500
Received: from services.cam.org ([198.73.180.252]:43953 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267102AbSL3WYj> convert rfc822-to-8bit;
	Mon, 30 Dec 2002 17:24:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
Date: Mon, 30 Dec 2002 17:32:21 -0500
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
References: <200212301645.50278.tomlins@cam.org> <1041288608.13956.173.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1041288608.13956.173.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Message-Id: <200212301732.21500.tomlins@cam.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 30, 2002 05:50 pm, Alan Cox wrote:
> Very interesting, but I'll note there are actually two groupings to
> solve - per user and per threadgroup. Also for small numbers of threads
> you don't want to punish a task and ruin its balancing across CPUs

This easily tuneable.  As its set now 2 in queue threads from the
same group are not punished, 3 and they have their timeslices halfed.
Setting THREAD_PENALTY to 65 means no adjustments till 4 in queue threads
exist.

> Have you looked at the per user fair share stuff too ?

No but a varient of the same code could be cooked up - interested?.  As 
I am the only real user here is not much of an issue.  Anyone have
boxes that can be used to test per user throttles?

Ed Tomlinson 

