Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUD1XSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUD1XSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUD1XSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:18:02 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:55817 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261181AbUD1XR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:17:59 -0400
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1083193995@astro.swin.edu.au>
Subject: Re:  State of linux checkpointing?
In-reply-to: <409012A4.9000502@pobox.com>
References: <c6oorn$3dq$1@sea.gmane.org> <409012A4.9000502@pobox.com>
X-Face: +*%dmR:3=9i\[:8fga\UgZT#@`f=DU0(wQqI'AR2/r0sBMO}Ax\,V*cWaW-owRlUmuz&=v\KItx0:gRCBg1&z_"4x&-N#Di7))]~p2('`6|5.c3&:Z?VLU`Zt5Kb,~uC6<y}P'~7A+^'|'+iAd4t43:P;tPiT<q=9P$MO]u^@OHn1_4#qP7,XiSo21SkgI`:5=i$,t&uNN_\LfuLyH`)8!:Tb]Z
Message-ID: <slrn-0.9.7.4-11992-4650-200404290913-tc@hexane.ssi.swin.edu.au>
Date: Thu, 29 Apr 2004 09:17:56 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> said on Wed, 28 Apr 2004 16:23:00 -0400:
> Neal D. Becker wrote:
> > I wonder if there is a checkpointing that will work with 2.6 kernels?
> > 
> > I only need relatively basic checkpointing.  No sockets or fancy stuff.
> 
> You only need checkpointing when your application programmers are lazy 
> and don't care about data integrity.  :)

Or you are running some kind of cluster where you want the
applications to be checkpointed transparently without the application
knowing the details of how or when they will be swapped out (but this
will need sockets anyway, so won't happen anytime soon).

'Tis a pain that the alpha cluster here can suspend long running jobs
for a pile of smaller jobs, and then resume, but the linux cluster can
do no such fanciness (yes, we do manual checkpointing, but it's prone
to bugs - and finding such a bug after 30 days of compute time really
sucks balls).


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Beware of Programmers who carry screwdrivers.
