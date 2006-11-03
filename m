Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753442AbWKCSkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbWKCSkD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbWKCSkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:40:03 -0500
Received: from mx1.suse.de ([195.135.220.2]:33664 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753442AbWKCSkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:40:01 -0500
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.19-rc1: x86_64 slowdown in lmbench's fork
Date: Fri, 3 Nov 2006 19:39:59 +0100
User-Agent: KMail/1.9.5
Cc: tim.c.chen@linux.intel.com, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <1162485897.10806.72.camel@localhost.localdomain> <200611031847.49222.ak@suse.de> <m18xisxul1.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xisxul1.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611031939.59208.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Which invalidates the tlb fault hypothesis unless it happens to lie
> on the 2MB boundary.

It's in different pages than the code. 

One drawback of using large TLBs is that the CPUs tend to have a lot less
of them than small TLBs so they can actually thrash quicker if you're unlucky.

Only profiling can tell I guess.

-Andi
