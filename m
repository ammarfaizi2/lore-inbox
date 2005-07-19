Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVGSSg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVGSSg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGSSg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:36:26 -0400
Received: from mail.yosifov.net ([193.200.14.114]:53943 "EHLO home.yosifov.net")
	by vger.kernel.org with ESMTP id S261822AbVGSSgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:36:25 -0400
Subject: Re: Noob question. Why is the for-pentium4 kernel built with
	-march=i686 ?
From: Ivan Yosifov <ivan@yosifov.net>
Reply-To: ivan@yosifov.net
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507191950020.89@yvahk01.tjqt.qr>
References: <1121792852.11857.6.camel@home.yosifov.net>
	 <Pine.LNX.4.61.0507191950020.89@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 21:35:51 +0300
Message-Id: <1121798151.15700.9.camel@home.yosifov.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-19 at 19:52 +0200, Jan Engelhardt wrote:
> >Hello,
> >
> >If I set the CPU type to be amd64 in kernel config, the kernel is built
> >with -march=k8. If I set it to be k6, the kernel is built with
> >-march=k6. If I set the CPU type to be Pentium4, the kernel is built
> >with -march=i686 -mtune=pentium4. Why is not the for-P4 kernel built
> >with -march=pentium4 ? 
> >I tried building the kernel with -march=pentium4  for the sake of
> >experiment and got no ill effects.
> 
> -march= specifies the instruction set, -mcpu= / -mtune= the tuning factor. 
> Maybe it is that the instruction set is the same on i686 and 
> pentium4. cmov for example is not present in k6, and k8 is something 
> completely different at all.
> 
> 
> Jan Engelhardt

-march implies -mtune and also implies thing like -msse2 for the
instruction set where applicable. 
I think -march=pentium4 is equivalent to -mmmx -msse -msse2
-mtune=pentium4 ( if I have not fogotten anything ).  
Pentium4 supports things like sse2 and mmx which AFAIK plain i686 does
not. I first thought that maybe the kernel was destabilized by such
optimizations, but k8 has all of them and more ( sse3 ). 
So, if it is ok to build the k8 kernel with -march=k8 why is it not ok
to built the p4 kernel with -march=pentium4 ? 
I may be wrong, but any way I think of it it looks like a performance
hit to build a p4 kernel with -march=i686.

Ivan Yosifov.

