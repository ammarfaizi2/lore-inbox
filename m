Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268689AbUILMcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268689AbUILMcH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUILMcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:32:07 -0400
Received: from ozlabs.org ([203.10.76.45]:37774 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268689AbUILMcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 08:32:05 -0400
Date: Sun, 12 Sep 2004 22:30:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk, wli@holomorphy.com
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912122959.GN25741@krispykreme>
References: <20040912085609.GK32755@krispykreme> <1094991480.2626.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094991480.2626.0.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> there are a lot of other reasons why you can't go over 64k threads ;)
> (esp on a 32 bit machine)

After all the effort of going to 4kB stacks on x86? :)

> such as all the 16 bit counters in rwsems etc etc... 
> Just Say No(tm) :)

Hmm can you point the 16bit counter out? I can create 1 million NPTL
threads on ppc64 easily, so why not?

As Ingo points out the same proc inode overflow happens with
applications with lots of FDs. 

Anton
