Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVIMH1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVIMH1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 03:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVIMH1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 03:27:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59610 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932429AbVIMH1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 03:27:42 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64 
In-reply-to: Your message of "Mon, 12 Sep 2005 23:59:37 MST."
             <20050913065937.GA7849@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Sep 2005 17:27:30 +1000
Message-ID: <25288.1126596450@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2005 23:59:37 -0700, 
Greg KH <greg@kroah.com> wrote:
>On Tue, Sep 13, 2005 at 04:17:33PM +1000, Keith Owens wrote:
>> The last time that tg3 broke like this, it was because of the patch
>> below, in 2.6.13-rc6.  That was backed out in 2.6.13-rc7.  Was the PCI
>> patch (or equivalent) reinstated in 2.6.14-rc1?
>> 
>> From: John W. Linville <linville@tuxdriver.com>
>> Date: Fri, 5 Aug 2005 01:06:10 +0000 (-0700)
>> Subject: [PATCH] PCI: restore BAR values after D3hot->D0 for devices that need it
>> X-Git-Tag: v2.6.13-rc6
>> X-Git-Url: http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=fec59a711eef002d4ef9eb8de09dd0a26986eb77
>
>So does reverting this patch solve the problem?

I reversing
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=064b53dbcc977dbf2753a67c2b8fc1c061d74f21,
which appears to be the latest version of this patch.  There was a
patch reject in sparc64, but the common code was reverted.  IA64 (SGI
Altix) with that patch reverted now boots 2.6.14-rc1.

