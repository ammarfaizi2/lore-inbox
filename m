Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268352AbUHTRUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268352AbUHTRUU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268389AbUHTRUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:20:20 -0400
Received: from open.hands.com ([195.224.53.39]:27557 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268352AbUHTRUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:20:13 -0400
Date: Fri, 20 Aug 2004 18:31:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: James Morris <jmorris@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Message-ID: <20040820173124.GA11086@lkcl.net>
Mail-Followup-To: Kaigai Kohei <kaigai@ak.jp.nec.com>,
	James Morris <jmorris@redhat.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	"SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
	"Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 10:36:03PM +0900, Kaigai Kohei wrote:
> Hello, everyone.
> 
> Tuesday, August 17, 2004 12:19 AM
> James Morris wrote:
> > > Is removing direct reference to AVC-Entry approach acceptable?
> > > 
> > > I'll try to consider this issue further.
> > 
> > Sure, if you can make it work without problems.
> 
> The attached patches against to 2.6.8.1 kernel improve the performance
> and the scalability of SELinux by RCU-approach.
> 
> The evaluation results are as follows:
> <Environment>
> CPU: Itanium2(1GHz) x 4/8/16/32
> Memory: enough (no swap)
> OS: 2.6.8.1 (SELinux disabled by 'selinux=0' boot option)
>     2.6.8.1 (SELinux enabled)
>     2.6.8.1 + rwlock patch by KaiGai
>     2.6.8.1 + RCU patch by KaiGai
> 
> The test program iterates write() to files on tmpfs 500,000 times in parallel.
                                                ^^^^^
 i presume that that is without the xattr patch which adds extended
 attributes to tmpfs?

 (see http://hands.com/~lkcl/selinux)

 l.

