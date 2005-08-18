Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVHRQTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVHRQTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVHRQTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:19:34 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:9961
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932280AbVHRQTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:19:33 -0400
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
	(update)
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Elliot Lee <sopwith@redhat.com>
In-Reply-To: <p7364u40zld.fsf@verdi.suse.de>
References: <1124326652.8359.3.camel@w2>  <p7364u40zld.fsf@verdi.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Aug 2005 18:19:11 +0200
Message-Id: <1124381951.6251.14.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 04:05 +0200, Andi Kleen wrote:

> Is there a realistic use case where this new system call is actually useful
> and solves something that cannot be solved without it?

As an example: It seems to be a common problem with numerous services to
run out of available file descriptors. There are several workarounds to
this problem, the most common seems to be increasing the systemwide max
number of filedescriptors and restarting the service. If you google for
e.g. 'linux "too many open files"' you get a bunch of mailing list
support requests about that problem.

Also some documention for specific services show that there is a need to
adjust rlimits per process at runtime, e.g.:
http://www.squid-cache.org/Doc/FAQ/FAQ-11.html#ss11.4
http://slacksite.com/apache/logging.html
http://staff.in2.hr/denis/oracle/10g1install_fedora3_en.html#n2

Thanks,
Wieland
