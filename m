Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUIJUOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUIJUOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIJUOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:14:34 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60429 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267769AbUIJUOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:14:31 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes() faster
Date: Fri, 10 Sep 2004 23:14:24 +0300
User-Agent: KMail/1.5.4
Cc: William Lee Irwin III <wli@holomorphy.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <4140791F.8050207@sw.ru> <20040909120818.7f127d14.akpm@osdl.org> <41416BCA.3020005@sw.ru>
In-Reply-To: <41416BCA.3020005@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409102314.24906.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> The only motive I'm aware of is for latency in the presence of things
> >> such as autofs. It's also worth noting that in the presence of things
> >> such as removable media umount is also much more common. I personally
> >> find this sufficiently compelling. Kirill may have additional
> >> ammunition.
> >
> > Well.  That's why I'm keeping the patch alive-but-unmerged.  Waiting to
> > see who wants it.
> >
> > There are people who have large machines which are automounting hundreds
> > of different NFS servers.  I'd certainly expect such a machine to
> > experience ongoing umount glitches.  But no reports have yet been sighted
> > by this little black duck.
>
> I think It's not always evident where the problem is. For many people
> waiting 2 seconds is ok and they pay no much attention to this small
> little hangs.
>
> 1. I saw the bug in bugzilla from NFS people you pointed to me last time
> yourself where the same problem was detected.

What bug? Are you talking about umount being not so fast or something else?
--
vda

