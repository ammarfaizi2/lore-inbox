Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUH3Piy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUH3Piy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUH3Pix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:38:53 -0400
Received: from [144.51.25.10] ([144.51.25.10]:40104 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S268503AbUH3Pit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:38:49 -0400
Subject: Re: [PATCH]SELinux performance improvement by RCU (Re: RCU issue
	with SELinux)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
	 <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil>
	 <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil>
	 <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil>
	 <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093526652.9280.104.camel@moss-spartans.epoch.ncsc.mil>
	 <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093880119.5447.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 30 Aug 2004 11:35:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 07:17, Kaigai Kohei wrote:
> I fixed the take-3 patch according to your and Paul's suggestions.
> 
> The attached take-4 patches replace the avc_lock in security/selinux/avc.c
> by the lock-less read access with RCU.

Thanks.  Was there a reason you didn't move the rcu_read_lock call after
the avc_insert call per the suggestion of Paul McKenney, or was that
just an oversight?  No need to send a new patch, just ack whether or not
you meant to switch the order there.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

