Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTJFIiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbTJFIiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:38:06 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27148
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262824AbTJFIiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:38:04 -0400
Date: Mon, 6 Oct 2003 01:38:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
Message-ID: <20031006083803.GB1135@matchmail.com>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031006082340.GA1135@matchmail.com> <1065428996.5033.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065428996.5033.5.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 10:29:56AM +0200, Arjan van de Ven wrote:
> On Mon, 2003-10-06 at 10:23, Mike Fedyk wrote:
> > Hi LK,
> > 
> > A while back (after 2.6.0-test2-mm1 which came to 6.4MB compressed, and
> > 2.6.0-test3-mm2 which came out to 34MB compressed), I noticed that the file
> > sizes for compiled object code got a lot bigger.  I reported it at the time,
> > but nobody was interested.
> > 
> > Today after using 2.6.0-test4-mm3 for a few weeks, I decided to upgrade to
> > test6 and it's up to 71MB compressed!
> 
> 
> CONFIG_DEBUG_INFO=y
> 
> makes the kernel be compiled with -g which gives it debuginfo, which
> basically ends up being the entire sourcecode included in the
> modules/kernel
> 

Thanks Arjan.

config DEBUG_INFO
	bool "Compile the kernel with debug info"
	depends on DEBUG_KERNEL
	help
          If you say Y here the resulting kernel image will include
	  debugging info resulting in a larger kernel image.
	  Say Y here only if you plan to use gdb to debug the kernel.
	  If you don't debug the kernel, you can say N.

"Larger kernel image" yeah, NO SHIT! ;)

Maybe something that says it may enlarge your kernel by 5-10 times would be
nice...
