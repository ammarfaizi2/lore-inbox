Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbUC3LiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUC3LiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:38:09 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:41109 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263617AbUC3LiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:38:04 -0500
Message-ID: <40695C68.4A5F551E@nospam.org>
Date: Tue, 30 Mar 2004 13:39:20 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Migrate pages from a ccNUMA node to another - patch
References: <4063F581.ACC5C511@nospam.org> <1080321646.31638.105.camel@nighthawk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Have you considered any common ground your patch might share with the
> people doing memory hotplug?
> 
>         http://people.valinux.co.jp/~iwamoto/mh.html
> 
> They have a similar problem to your migration that occurs when a user
> wants to remove a whole or partial NUMA node.
> lhms-devel@lists.sourceforge.net

Comparing my stuff to their work, I just do some small performance enhancements:

- I do not modify a single line on the existing VM paths - if my stuff has no
  improvement for you, then yo will not be obliged to pay any overhead
- I do not insist on :-)) ... that would block the execution of the application
  while the resources are not available
- I handle only the simplest case: private anonymous pages (...a singe PTE...)

- IWAMOTO Toshihiro provides a complete "fool proof" solution with obligation to
  cussed in the migration

> Is your code something that you'd like to see go into the mainline 2.6
> or 2.7 kernel?

Since someone is asking...

Thanks,

Zoltán
