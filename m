Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWGQSTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWGQSTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWGQSTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:19:41 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:34224 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751126AbWGQSTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:19:40 -0400
Message-ID: <44BBD4B6.5020801@namesys.com>
Date: Mon, 17 Jul 2006 11:19:34 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com> <44BB0146.7080702@suse.com> <44BB3C42.1060309@namesys.com> <44BBA4CF.8020901@suse.com>
In-Reply-To: <44BBA4CF.8020901@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

> Hans Reiser wrote:
>
> >I don't understand your patch and cannot support it as it is written.  
> >Perhaps you can call me and explain it on the phone.
>
>
> I seriously can't tell if you're deliberately trying to be difficult or
> not. It's a simple "replace / with ! before sending the name to procfs."
>
> Reiserfs requests that a procfs directory called
> /proc/fs/reiserfs/<blockdev> be created. Some block devices contain
> slashes, so with cciss/c123 it attempts to create a directory called
> /proc/fs/reiserfs/cciss/c123, but cciss/ doesn't exist, shouldn't, and
> never will.

Why not check to see if it does not exist, and create it if not,  as
needed,  and skip the !'s....?

> In order to create a single path component, "cciss/c123"
> becomes "cciss!c123." This is consistent with how sysfs does it now. For
> a real example, change the "-" in device mapper block names to "/" and
> see what happens.
>
> Regardless, it's already been checked into mainline as change
> 6fbe82a952790c634ea6035c223a01a81377daf1.
>
> -Jeff
>
> --
> Jeff Mahoney
> SUSE Labs

