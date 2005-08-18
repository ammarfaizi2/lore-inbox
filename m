Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVHRRWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVHRRWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVHRRWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:22:03 -0400
Received: from [81.2.110.250] ([81.2.110.250]:8834 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932291AbVHRRWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:22:01 -0400
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
	(update)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: e8607062@student.tuwien.ac.at
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1124381951.6251.14.camel@w2>
References: <1124326652.8359.3.camel@w2>  <p7364u40zld.fsf@verdi.suse.de>
	 <1124381951.6251.14.camel@w2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Aug 2005 18:49:01 +0100
Message-Id: <1124387342.16072.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also some documention for specific services show that there is a need to
> adjust rlimits per process at runtime, e.g.:
> http://www.squid-cache.org/Doc/FAQ/FAQ-11.html#ss11.4
> http://slacksite.com/apache/logging.html
> http://staff.in2.hr/denis/oracle/10g1install_fedora3_en.html#n2

Perhaps those application authors should provide a management interface
to do so within the soft limit range at least. Its not clear to me that
growing the fd array on a process is even safe. Some programs do size
arrays at startup after querying the rlimit data.

