Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVFOUrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVFOUrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVFOUqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:46:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19423 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261564AbVFOUoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:44:37 -0400
Date: Wed, 15 Jun 2005 15:49:36 -0500
From: serue@us.ibm.com
To: James Morris <jmorris@redhat.com>
Cc: Reiner Sailer <sailer@watson.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Tom Lendacky <toml@us.ibm.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615204936.GA3517@serge.austin.ibm.com>
References: <1118846413.2269.18.camel@secureip.watson.ibm.com> <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@redhat.com):
> On Wed, 15 Jun 2005, Reiner Sailer wrote:
> 
> > This patch applies against linux-2.6.12-rc6-mm1 and provides the main
> > Integrity Measurement Architecture code (LSM-based).
> 
> Why are you still trying to use LSM for this?

A long, long time ago, Crispin defined LSM's purpose as:

>> Main goal : we have to design a generic framework to be able to use
>> better
>> security policies than the current ones (DAC and capabilities).
>
>Sort of. We have to design a generic interface that exports enough
>kernel
>functionality to allow security developers to go off and create these
>better
>security policy modules. 

Since IMA provides support for a new type of security policy,
specifically remote system integrity verification, I don't see
where LSM shouldn't necessarily be used.

I'm also curious about the current kernel development approach:
On the one hand, when filesystem auditing was introduced, Christoph
asked whether inotify and audit should be merged because they hook
some of the same places.  Can someone reconcile these points of view
for me, please?  If Reiner goes ahead and moves the IMA code straight
into the kernel, does anyone doubt that he'll be asked to merge it
with LSM?

I'm not pushing one way or the other - I don't care whether IMA is
an LSM or not :)  I just don't understand the current climate.

thanks,
-serge
