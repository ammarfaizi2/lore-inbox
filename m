Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWFXBPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWFXBPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933176AbWFXBPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:15:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:34966 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751683AbWFXBPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:15:30 -0400
From: Andi Kleen <ak@suse.de>
To: "Keith Mannthey" <kmannth@gmail.com>
Subject: Re: [PATCH] [20/82] i386: Panic the system when a NUMA kernel doesn't run on IBM NUMA
Date: Sat, 24 Jun 2006 03:15:56 +0200
User-Agent: KMail/1.9.1
Cc: "Dave Jones" <davej@redhat.com>, torvalds@osdl.org, discuss@x86-64.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <449C8510.mailCWD11E44E@suse.de> <200606240242.31906.ak@suse.de> <a762e240606231803p72e4e684v42cf27cdaf8fb30f@mail.gmail.com>
In-Reply-To: <a762e240606231803p72e4e684v42cf27cdaf8fb30f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606240315.56365.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I agree that i386 CONFIG_NUMA is only ment to boot on small subset of
> hw but there is litte motivation to boot a numa kernel on a non-numa
> box.  I am supprised that no one has enabled i386 AMD NUMA (the one
> numa box that regular people have access to).

I never bothered because 32bit NUMA with lowmem only on node 0 
isn't very useful. Using it with 64bit makes much more sense.

> > I'm sure someone will bring up now an example where their non Summit
> > machine booted with CONFIG_NUMA, but they were just extremly lucky
> > and unlikely to be for very long.
>
> Current Summit HW  (x460) dosen't use/have a cyclone.  There are
> patches submitted to this list to support it's i386 NUMA boot.

Hmm, that's a good point. When the detection doesn't work
reliable it's no good.

Ok, Linus please don't apply that patch for now then.

-Andi
