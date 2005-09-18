Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVIRQfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVIRQfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVIRQfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:35:04 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13828 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932114AbVIRQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:35:03 -0400
Date: Sun, 18 Sep 2005 18:34:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org
Subject: Re: Eradic disk access during reads
Message-ID: <20050918163450.GA1516@alpha.home.local>
References: <200509170717.03439.a1426z@gawab.com> <200509181400.27004.vda@ilport.com.ua> <200509181640.19984.a1426z@gawab.com> <200509181902.17633.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509181902.17633.vda@ilport.com.ua>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 07:02:17PM +0300, Denis Vlasenko wrote:
> > > My CPU is not that new:
> > 
> > PII - 400Mhz here.
> 
> I meant that kernel seem to eat too much CPU here. This
> is not expected. I expected CPU bar to be all D.

This is often caused by disks running in PIO instead of DMA.

> > Also, great meter!  Best of all does not hog the CPU!
> > Could you add a top3 procs display?
> 
> What is a "top3 procs display"?

probably something which will turn your tool into sort of a complex and
unusable one when another session running 'top' could do the trick.

Oh, BTW, the first reason I wrote my tool was to avoid copying into
/dev/null which consumes a small amount of CPU. Thus, I made it a pure
data eater. It might be interesting to run it instead of 'dd' while your
tool is running, to see if system usage decreases a bit.

Regards,
Willy

