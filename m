Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUEAQSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUEAQSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 12:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUEAQSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 12:18:37 -0400
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:16737
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S262422AbUEAQP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 12:15:57 -0400
Subject: Re: Large page support in the Linux Kernel?
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Buddy Lumpkin <b.lumpkin@comcast.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <S262103AbUEAJXe/20040501092334Z+498@vger.kernel.org>
References: <S262103AbUEAJXe/20040501092334Z+498@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083428150.3810.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Sat, 01 May 2004 12:15:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-01 at 05:28, Buddy Lumpkin wrote:
> Lastly, I know I have mentioned Oracle and Solaris a lot. Please don't flame
> me for this, I think the points I am trying to make are reasonable.

The only reason to be flamed is that you didn't seem to do much research
before posting.  RHEL 2.1 has supported a feature called "BigPages"
specifically used for Oracle for quite a while.  Good documentation on
how to set this up can be found from Redhat, Oracle, and a quick Google
search.

See
http://www.puschitz.com/TuningLinuxForOracle.shtml#UsingLargeMemoryPages
for instructions on how to set it up.  Basically you pass a kernel
parameter to tell the system how much memory to allocate as big pages
and the kernel reserves this memory for it's use.

RHEL 3.0 and current 2.6 kernel support a newer variant called Hugetlb
which seems similar from a user perspective but I'm not sure of the
implementation details.  It more dynamic, you can decrease or increase
memory allocated to Hugetlb's via /proc athough, you can't always grow
it (the kernel has to be able to allocate contiguous segments to grow
the system).  I'm not aware of any instruction in the community about
how to set this up, but Oracle's Metalink provides complete
instructions.  I'm already using it on my five production Oracle
instances and have had no problems with it.

Later,
Tom


