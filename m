Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUH3QRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUH3QRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUH3QRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:17:25 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:53886 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268534AbUH3QRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:17:22 -0400
Date: Mon, 30 Aug 2004 09:13:28 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH]SELinux performance improvement by RCU (Re: RCU issue with SELinux)
Message-ID: <20040830161328.GC1243@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp> <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil> <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp> <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil> <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp> <1093526652.9280.104.camel@moss-spartans.epoch.ncsc.mil> <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp> <1093880119.5447.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093880119.5447.87.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 11:35:19AM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-30 at 07:17, Kaigai Kohei wrote:
> > I fixed the take-3 patch according to your and Paul's suggestions.
> > 
> > The attached take-4 patches replace the avc_lock in security/selinux/avc.c
> > by the lock-less read access with RCU.
> 
> Thanks.  Was there a reason you didn't move the rcu_read_lock call after
> the avc_insert call per the suggestion of Paul McKenney, or was that
> just an oversight?  No need to send a new patch, just ack whether or not
> you meant to switch the order there.

One reason might be because I called it out in the text of my message,
but failed to put it in my patch.  :-/  Of course, if there is some reason
why moving the rcu_read_lock() call is bad, I would like to know for
my own education.

						Thanx, Paul
