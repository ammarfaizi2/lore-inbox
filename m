Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUFCRzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUFCRzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUFCRzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:55:41 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:59656 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S263713AbUFCRzQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:55:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlinks for building external modules
References: <200406031858.09178.agruen@suse.de> <yw1x8yf44lgp.fsf@kth.se>
	<20040603173656.GA2301@mars.ravnborg.org>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Thu, 03 Jun 2004 19:55:10 +0200
In-Reply-To: <20040603173656.GA2301@mars.ravnborg.org> (Sam Ravnborg's
 message of "Thu, 3 Jun 2004 19:36:56 +0200")
Message-ID: <yw1x4qps4jcx.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Thu, Jun 03, 2004 at 07:09:42PM +0200, Måns Rullgård wrote:
>> Andreas Gruenbacher <agruen@suse.de> writes:
>> 
>> > Hi Sam,
>> >
>> > modules not in the kernel source tree need to locate both the source
>> > tree and the object tree (O=). Currently, the /lib/modules/$(uname
>> > -r)/build symlink is the only reference we have; it historically
>> > points to the source tree from 2.4 times. The following patch
>> > changes this as follows (this is what we have in the current SUSE
>> > tree now):
>> >
>> > 	/lib/modules/$(uname -r)/source ==> source tree
>> > 	/lib/modules/$(uname -r)/build ==> object tree
>> 
>> This will break the building of all external modules until they are
>> updated, and break updated modules building against older kernels
>> unless they check the kernel version in the makefiles..  I suggest
>> leaving the 'build' link as is, and using a difference name for the
>> build directory, perhaps 'object'.  This might look confusing, so we
>> could have a 'source' link as well and remove the 'build' link when
>> most external modules have been updated.
>
> The existing external modules are anyway broken when using separate 
> directories for source and output directories.

They work fine if you pass O=/some/path on the make command line.

> So noting lost here.  In the case where the kernel is build in the
> traditional way the build and source tree will point to the same
> place.

True.

> So I do not see this patch breaking existing setups, but I see
> external modules not being prepared for separate build and source
> directories.
>
> Patch looks good to me, and I will forward to Andrew soon.

I'll just have to go fix my kernel modules then.

-- 
Måns Rullgård
mru@kth.se
