Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268167AbUHTO6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268167AbUHTO6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHTO6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:58:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268167AbUHTOyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:54:05 -0400
Date: Fri, 20 Aug 2004 10:53:55 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
In-Reply-To: <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0408201052160.22200-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Kaigai Kohei wrote:

> The attached patches against to 2.6.8.1 kernel improve the performance
> and the scalability of SELinux by RCU-approach.


>                  --- 4CPU ---  --- 8CPU ---  --- 16CPU ---  --- 32CPU ---
> 2.6.8.1(disable)    8.0158[s]     8.0183[s]      8.0146[s]      8.0037[s]
>                  (2.08/ 6.07)   (1.86/6.31)   (0.78/ 7.33)    (2.03/5.94)
> 2.6.8.1(enable)    78.0957[s]   319.0451[s]   1322.0313[s]      too long 
>                  (2.47/76.48) (2.47/316.96)  (2.43/1319.8)     (---/---) 
> 2.6.8.1.rwlock     20.0100[s]    49.0390[s]     90.0200[s]    177.0533[s]
>                  (2.57/17.52)  (2.45/46.93)   (2.37/87.78)   (2.41/175.1)
> 2.6.8.1.rcu        11.0464[s]    11.0205[s]     11.0372[s]     11.0496[s]
>                   (2.64/8.82)   (2.21/8.98)   (2.67/ 8.68)    (2.51/8.95)
> -------------------------------------------------------------------------

Do you have figures for 1 and 2 CPU?

Also, can you run some more benchmarks, e.g. lmbench, unixbench, dbench 
etc?


- James
-- 
James Morris
<jmorris@redhat.com>


