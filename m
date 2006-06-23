Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752076AbWFWVRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbWFWVRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWFWVRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:17:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35024 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752076AbWFWVRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:17:35 -0400
To: "" <matthltc@us.ibm.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Peter Williams" <pwil3058@bigpond.net.au>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Jes Sorensen" <jes@sgi.com>,
       "LSE-Tech" <lse-tech@lists.sourceforge.net>, "" <sekharan@us.ibm.com>,
       "Alan Stern" <stern@rowland.harvard.edu>,
       "Balbir Singh" <balbir@in.ibm.com>,
       "Shailabh Nagar" <nagar@watson.ibm.com>
Subject: Re: [PATCH] Per-task watchers: Enable inheritance
X-US-Snail: Rational Software, IBM Software Group, 20 Maguire Road, Lexington, MA  02421-3112
References: <1150879635.21787.964.camel@stark>
From: jtk@us.ibm.com (John T. Kohl)
Date: 23 Jun 2006 17:17:22 -0400
In-Reply-To: <1150879635.21787.964.camel@stark>
Message-ID: <6c4pybmv19.fsf@sumu.lexma.ibm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MattH" ==   <matthltc@us.ibm.com> writes:

MattH> This allows per-task watchers to implement inheritance of the
MattH> same function and/or data in response to the initialization of
MattH> new tasks. A watcher might implement inheritance using the
MattH> following notifier_call snippet:

I think this would meet our needs--we (MVFS) need to initialize some new
state in a child process based on our state in the parent process
(essentially, module-private inherited per-process state).  It may still
be a bit clumsy to find the per-process state in other situations,
though.  While a process is executing our module's code, would it be
safe to traverse current's notifier chain to find our state?

-- 
John Kohl
Senior Software Engineer - Rational Software - IBM Software Group
Lexington, Massachusetts, USA
jtk@us.ibm.com
<http://www.ibm.com/software/rational/>
