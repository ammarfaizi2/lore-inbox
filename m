Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWIIOhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWIIOhx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWIIOhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:37:53 -0400
Received: from stine.vestdata.no ([217.149.127.10]:38882 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP id S932219AbWIIOhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:37:52 -0400
Date: Sat, 9 Sep 2006 16:37:44 +0200
From: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060909143744.GZ16876@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Zet.no-MailScanner-Information: Please contact the ISP for more information
X-Zet.no-MailScanner: Found to be clean
X-MailScanner-From: ragnark@stine.vestdata.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I'm not subscribed. Please CC me on replies ]

> Solution:
> 
> The solution can come in multiple steps.
> 
> Suggested fix #1: kernel
> Patch below sorts the two device lists into breadth-first ordering to
> maintain compatibility with 2.4 kernels.  It also overloads the
> 'pci=nosort' option to disable the breadth-first sort (and on i386 it
> continues to disable the pcibios_find_device sort as well).

As far as I understand it's difficult to argue that sorting the devices
one way is more "correct" than the other, so your argument is basically:
1) Compability with 2.4
2) Consistency with BIOS and external labels.

Both are important, but the problem is
1) Compability with 2.4 means breaking compability with previous
   2.6 kernels. And 2.6 has been out long enough that it's more
   important than 2.4.
2) There is also hardware where the 2.6 behaviour is consistent with
   BIOS and external labels where 2.4 is not.

An _option_ to enable 2.4 compatible device ordering on the other hand
would have just advantages, no disadvantages.


-- 
Ragnar Kjørstad
Software Engineer
Scali - http://www.scali.com
Scaling the Linux Datacenter
