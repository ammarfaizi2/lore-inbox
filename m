Return-Path: <linux-kernel-owner+w=401wt.eu-S1161154AbXALWym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbXALWym (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbXALWym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:54:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161154AbXALWyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:54:41 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steven Fernandez <sfernand@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] raw: don't allow the creation of a raw device with minor number 0
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <x49bql48aus.fsf@segfault.boston.devel.redhat.com>
	<Pine.LNX.4.61.0701122341030.19224@yvahk01.tjqt.qr>
From: jmoyer@redhat.com
Date: Fri, 12 Jan 2007 17:58:41 -0500
In-Reply-To: <Pine.LNX.4.61.0701122341030.19224@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Fri, 12 Jan 2007 23:41:28 +0100 (MET)")
Message-ID: <m38xg73l9a.fsf@redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] raw: don't allow the creation of a raw device with minor number 0; Jan Engelhardt <jengelh@linux01.gwdg.de> adds:

jengelh> On Jan 12 2007 11:32, Jeff Moyer wrote:

>> Date: Fri, 12 Jan 2007 11:32:11 -0500
>> From: Jeff Moyer <jmoyer@redhat.com>
>> To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>> Cc: Steven Fernandez <sfernand@redhat.com>, Andrew Morton <akpm@osdl.org>
>> Subject: [patch] raw: don't allow the creation of a raw device with minor
>> number 0
>> 
>> Hi,
>> 
>> Minor number 0 (under the raw major) is reserved for the rawctl device
>> file, which is used to query, set, and unset raw device bindings.
>> However, the ioctl interface does not protect the user from specifying
>> a raw device with minor number 0:

jengelh> No idea what to say about this... probably:

jengelh>   What:   RAW driver (CONFIG_RAW_DRIVER)
jengelh>   When:   December 2005
jengelh>   Why:    declared obsolete since kernel 2.6.3
jengelh>           O_DIRECT can be used instead
jengelh>   Who:    Adrian Bunk <bunk@stusta.de>

It's still present, still used, and so would benefit from being fixed, in
my opinion.

Cheers,

Jeff
