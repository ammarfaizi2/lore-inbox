Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSGUPSk>; Sun, 21 Jul 2002 11:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSGUPSk>; Sun, 21 Jul 2002 11:18:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:64245 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315278AbSGUPSk>; Sun, 21 Jul 2002 11:18:40 -0400
Subject: Re: memory leak?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1xwurptb1x.fsf@gladiusit.e.kth.se>
References: <Pine.LNX.4.44L.0207211118241.12241-100000@imladris.surriel.com> 
	<yw1xwurptb1x.fsf@gladiusit.e.kth.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 17:33:44 +0100
Message-Id: <1027269224.17234.101.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This memory will be reclaimed when the system needs it.
> 
> Does this mean that free and /proc/meminfo are incorrect?

By its own definition proc/meminfo is correct. top could go rummaging in
/proc/slabinfo but its questionable if it is meaningful to do so. The
actually "out of memory" case for a virtual memory system is not "no
memory pages free" nor "no memory or swap free" its closer to "working
set plus i/o buffers exceeds memory size".

That isnt something as easy to visualise or compute as "free"

