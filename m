Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbTIEEHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 00:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbTIEEHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 00:07:47 -0400
Received: from opersys.com ([64.40.108.71]:25605 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262067AbTIEEHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 00:07:45 -0400
Message-ID: <3F580CCF.5010109@opersys.com>
Date: Fri, 05 Sep 2003 00:10:55 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SMP clusters, CC-Clusters and friends ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Having spent quite some time in the summer of 2002 figuring out many of the
various practical issues of implementing Linux SMP clusters, I was quite happy
to see some actual discussion on the topic on LKML. Unfortunately the discussion
has centered mostly on philosophical issues, and I wasn't interested very much
in those: though I believe the kernel can be made to scale, and has done so
successfully in the past, I think that an SMP cluster will always scale to a
greater number of processors than the kernel can, regardless of its state of
development (i.e. if the kernel scales well to 256 CPUs, then an SMP cluster
using said kernel will scale to N*256, N being the number of cells/nodes to
which the upper-layer SSI software can scale). That's just for the scalability
argument, but there are other reasons why you'd want to have multiple
independent images running side-by-side, as others have pointed out ...

Personally, I'm much more interested in the how-do-we-do-this aspect of
discussion. Though Steven Cole pointed out the paper I wrote in July 2002
(thanks Steven), there's been little technical discussion around it.
Needless to say that I'd welcome any feedback anyone may have on the ideas
I put forth in the paper.

To recap, the architecture I'm suggesting has the following advantages:
- No changes to kernel's virtual memory code
- No changes to kernel's scheduler
- No changes to kernel's lock granularity
- Minimal low-level changes to kernel code
- Reuse of many existing software components
- Short-term accessibility

Unfortunately, I've been unable to put any time on this because of my
involvement in other projects and the fact that I have to pay the rent ;)
If anyone wants to take this forward on his own or if someone wants to fund
work on this, I'd be glad be to help.

Fortunately, I think the amount of work required to get a functional SMP
cluster seems to decrease with time. The work already done on kexec and
NUMA, for example, is sure to be of help in forking off multiple instances of
the same kernel. Actually, I had a very good discussion about the use of
kexec in the scheme I'm suggesting with Eric Biederman at the last OLS.

If you're still reading this and are interested in the actual implementation
of SMP clusters, have a look at what I'm suggesting and let me know what
you think:
http://www.opersys.com/ftp/pub/Adeos/practical-smp-clusters.ps
http://www.opersys.com/ftp/pub/Adeos/practical-smp-clusters.pdf
http://www.opersys.com/adeos/practical-smp-clusters/

Cheers,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

