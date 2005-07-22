Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVGVUWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVGVUWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVGVUWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:22:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:8376 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261269AbVGVUWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:22:42 -0400
Subject: Re: [ckrm-tech] Re: 2.6.13-rc3-mm1 (ckrm)
From: Matthew Helsley <matthltc@us.ibm.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: LKML <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0507221216090.25001-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0507221216090.25001-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 13:18:07 -0700
Message-Id: <1122063487.5242.255.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 12:35 -0400, Mark Hahn wrote:
<snip>

> actually, let me also say that CKRM is on a continuum that includes 
> current (global) /proc tuning for various subsystems, ulimits, and 
> at the other end, Xen/VMM's.  it's conceivable that CKRM could wind up
> being useful and fast enough to subsume the current global and per-proc
> tunables.  after all, there are MANY places where the kernel tries to 
> maintain some sort of context to allow it to tune/throttle/readahead
> based on some process-linked context.  "embracing and extending"
> those could make CKRM attractive to people outside the mainframe market.

	Seems like an excellent suggestion to me! Yeah, it may be possible to
maintain the context the kernel keeps on a per-class basis instead of
globally or per-process. The real question is what constitutes a useful
"extension" :).

	I was thinking that per-class nice values might be a good place to
start as well. One advantage of per-class as opposed to per-process nice
is the class is less transient than the process since its lifetime is
determined solely by the system administrator.

	CKRM calls this kind of module a "resource controller". There's a small
HOWTO on writing resource controllers here:
http://ckrm.sourceforge.net/ckrm-controller-howto.txt
If anyone wants to investigate writing such a controller please feel
free to ask questions or send HOWTO feedback on the CKRM-Tech mailing
list at <ckrm-tech@lists.sourceforge.net>.

Thanks,
	-Matt Helsley

