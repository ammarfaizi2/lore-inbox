Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUBHGdg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 01:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUBHGdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 01:33:36 -0500
Received: from cm6.gamma186.maxonline.com.sg ([202.156.186.6]:11911 "EHLO
	garfield.anomalistic.org") by vger.kernel.org with ESMTP
	id S262425AbUBHGde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 01:33:34 -0500
Date: Sun, 8 Feb 2004 14:33:32 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
Subject: Re: Unknown symbol _exit when compiling VMware vmmon.o module
Message-ID: <20040208063332.GA12490@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <1076175615.798.9.camel@teapot.felipe-alfaro.com> <yw1xad3u7oaw.fsf@kth.se> <1076180005.798.16.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076180005.798.16.camel@teapot.felipe-alfaro.com>
X-Operating-System: Linux 2.6.3-rc1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Felipe Alfaro Solana">
> On Sat, 2004-02-07 at 19:11, M??ns Rullg??rd wrote:
> > Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:
> > > After installing VMware Workstation 4.5.0-7174 and running
> > > vmware-config.pl, I get the following error when trying to insert
> > > vmmon.ko into the kernel:
> > >
> > > vmmon: Unknown symbol _exit
> > 
> > I've seen it too.  I just removed that call from the source and
> > rebuilt.  It's not supposed to ever get there anyway.  I still don't
> > understand what it was doing there in the first place.  Oddly, it
> > compiled with kernel 2.6.2, but not with some later updates.
> 
> Yeah! I experienced the same with -mm kernels... It seems the changes
> that motivated that have been integrated in mainline now. For now, I've
> removed any reference to _exit from the module sources.

reverse this patch: 
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm5/broken-out/gcc-35-exit-fix.patch

for more info, see http://www.anomalistic.org/#vmware

Eugene

-- 
Eugene TEO -  <eugeneteo%eugeneteo!net>   <http://www.anomalistic.org/>
1024D/14A0DDE5 print D851 4574 E357 469C D308  A01E 7321 A38A 14A0 DDE5
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

