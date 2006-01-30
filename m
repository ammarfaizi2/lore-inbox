Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWA3GME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWA3GME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 01:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWA3GMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 01:12:03 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:46233 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751248AbWA3GMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 01:12:02 -0500
Message-ID: <43DDAE2D.6080300@namesys.com>
Date: Sun, 29 Jan 2006 22:11:57 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Denis Vlasenko <vda@ilport.com.ua>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
References: <200601281613.16199.vda@ilport.com.ua> <200601281701.02533.vda@ilport.com.ua> <200601281811.35690.vda@ilport.com.ua>
In-Reply-To: <200601281811.35690.vda@ilport.com.ua>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris, would Denis Vlasenko wrote:

>[CCing namesys]
>
>Narrowed it down to 100% reproducible case:
>
>	chown -Rc 0:<n> .
>
>in a top directory of tree containing ~21938 files
>on reiser3 partition:
>
>	/dev/sdc3 on /.3 type reiserfs (rw,noatime)
>
>causes oom kill storm. "ls -lR", "find ." etc work fine.
>
>I suspected that it is a leak in winbindd libnss module,
>but chown does not seem to grow larger in top, and also
>running it under softlimit -m 400000 still causes oom kills
>while chown's RSS stays below 4MB.
>--
>vda
>
>
>  
>
Chris, would you like to handle this?

Thanks,

Hans
