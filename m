Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWFOXSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWFOXSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWFOXSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 19:18:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:14988 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750747AbWFOXSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 19:18:36 -0400
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, libc-alpha@sourceware.org,
       libc-alpha-owner@sourceware.org, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
In-Reply-To: <OFACBE689D.E8F97DC8-ON8625718D.0050D65F-8625718D.0051EAD6@us.ibm.com>
References: <OFACBE689D.E8F97DC8-ON8625718D.0050D65F-8625718D.0051EAD6@us.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 09:17:58 +1000
Message-Id: <1150413478.7725.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> PowerPC has similar issues and could use VDSO/vsyscal to implement
> vgetcpu() as well. So we should get Ben Herrenschmidt involved to insure
> that we have a cross platform solution.

Except that I haven't yet found a way to pass the information to the
vdso... in the past, there used to be an SPRG that was readable by
userland that I could have used but I can't see that working on recent
CPUs. The PIR isn't quite portable (though the vDSO can have per-cpu
model) and we don't quite know for sure what's in there, especially on
shared processor machines.

Any idea ?

Ben.


