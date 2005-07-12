Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVGLEqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVGLEqh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGLEqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:46:37 -0400
Received: from opersys.com ([64.40.108.71]:21264 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262337AbVGLEqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:46:36 -0400
Message-ID: <42D349C9.3060805@opersys.com>
Date: Tue, 12 Jul 2005 00:40:41 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <20050712030555.GA1487@kroah.com> <42D3331F.8020705@opersys.com> <20050712032424.GA1742@kroah.com> <42D33E99.7030101@opersys.com> <20050712043056.GC2363@kroah.com>
In-Reply-To: <20050712043056.GC2363@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> The path/filename dictates how it is used, so putting relayfs type files
> in debugfs is just fine.  debugfs allows any types of files to be there.
...
> New trees in / are not LSB compliant, hence the reason for writing
> securityfs to get rid of /selinux and other LSM filesystems that were
> starting to sprout up.
...
> But that's exactly what debugfs is for, to allow data to be dumped out
> of the kernel for different usages.
...
> Ok, have a better name for it?  It's simple and easy to understand.

It also carries with it the stigma of "kernel debugging", which I just
don't see production system maintainers liking very much.

So tell you what, how about if we merged what's in debugfs into relayfs
instead? We'll still end up with one filesystem, but we'll have a more
inocuous name. After all, if debugfs is indeed for dumping data from the
kernel to user-space for different usages, then relaying is what it's
actually doing, right?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
