Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbSJCWn0>; Thu, 3 Oct 2002 18:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbSJCWn0>; Thu, 3 Oct 2002 18:43:26 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:58610 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261387AbSJCWnW>; Thu, 3 Oct 2002 18:43:22 -0400
Date: Thu, 3 Oct 2002 18:48:54 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] improve wchan reporting
Message-ID: <20021003184854.I16875@redhat.com>
References: <20021003182144.G16875@redhat.com> <Pine.LNX.4.44L.0210031928590.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0210031928590.22735-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Oct 03, 2002 at 07:30:13PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 07:30:13PM -0300, Rik van Riel wrote:
> A third option could be a /proc/$pid/backtrace file which
> contains the whole backtrace for a process and teach procps
> to ignore certain functions.

It should really be a separate filesystem, though....

> I prefer your solution, though ;)

There's another problem with the way wchan is currently calculated: it's 
relatively expensive to calculate.  Many of the readers of stat don't actually 
care about it.  By making wchan a value in the task structure, the cost of 
reading it is trivial.

		-ben
-- 
GMS rules.
