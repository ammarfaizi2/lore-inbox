Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVKXOci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVKXOci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVKXOci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:32:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:13440 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751085AbVKXOch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:32:37 -0500
Date: Thu, 24 Nov 2005 15:32:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
Message-ID: <20051124143237.GA1060@elte.hu>
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <Pine.LNX.4.58.0511230748000.23751@gandalf.stny.rr.com> <20051123135847.GF22714@in.ibm.com> <1132755344.13395.32.camel@localhost.localdomain> <20051124041608.GA16502@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124041608.GA16502@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Maneesh Soni <maneesh@in.ibm.com> wrote:

> > I'm already playing around with this. You might want this patch instead.
> > I noticed that if sysfs_make_dirent fails to allocate the sd, then a
> > null will be passed to sysfs_put.

> Agreed. This makes more sense.

ok, i've applied Steven's patch.

	Ingo
