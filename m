Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261714AbSJ2DZm>; Mon, 28 Oct 2002 22:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261717AbSJ2DZm>; Mon, 28 Oct 2002 22:25:42 -0500
Received: from alpha9.cc.monash.edu.au ([130.194.1.9]:58889 "EHLO
	ALPHA9.CC.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S261714AbSJ2DZk>; Mon, 28 Oct 2002 22:25:40 -0500
Date: Tue, 29 Oct 2002 14:30:22 +1100 (EST)
From: netdev-bounce@oss.sgi.com
To: undisclosed-recipients:;
Message-id: <20021029033022.1B454130071@splat.its.monash.edu.au>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 October 2002 16:59, Nivedita Singhvi wrote:
> bert hubert wrote:
> > > ...adding the whole profile output - sorted by the first column this
> > > time...
> > >
> > > 905182 total                                      0.4741
> > > 121426 csum_partial_copy_generic                474.3203
> > >  93633 default_idle                             1800.6346
> > >  74665 do_wp_page                               111.1086
> >
> > Perhaps the 'copy' also entails grabbing the page from disk, leading to
> > inflated csum_partial_copy_generic stats?
>
> I think this is strictly a copy from user space->kernel and vice versa.
> This shouldnt include the disk access etc.

hm

I'm doing O_DIRECT read (from disk), so it needs to be user -> kernel, then.

any chance of using O_DIRECT to the socket?

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.



