Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268728AbUJTSH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268728AbUJTSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268954AbUJTSHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:07:15 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:17318 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S268919AbUJTRzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:55:44 -0400
Subject: Re: [PATCH 2/3] ext3 reservation allow turn off for specifed file
From: Ray Lee <ray-lk@madrabbit.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com, pbadari@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	 <1097856114.4591.28.camel@localhost.localdomain>
	 <1097858401.1968.148.camel@sisko.scot.redhat.com>
	 <1097872144.4591.54.camel@localhost.localdomain>
	 <1097878826.1968.162.camel@sisko.scot.redhat.com>
	 <109787  <1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Wed, 20 Oct 2004 10:55:41 -0700
Message-Id: <1098294941.18850.4.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 18:01 -0700, Mingming Cao wrote:
> On Mon, 2004-10-18 at 16:42, Andrew Morton wrote:
> > Applications currently pass a seeky-access hint into the kernel via
> > posix_fadvise(POSIX_FADV_RANDOM).  It would be nice to hook into that

[...]

> Just thought seeky random write application could use the existing ioctl
> to let the kernel know it does not need reservation at all. Isn't that
> more straightforward?

Going the ioctl route seems to imply that userspace would have to do a
posix_fadvise() call and the ioctl, as opposed to just the fadvise. No?
I'm betting the fadvise call is a little more portable as well.

Ray

