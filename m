Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbUKUClU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUKUClU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 21:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbUKUClU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 21:41:20 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29916 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261748AbUKUClB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 21:41:01 -0500
Message-ID: <41A00046.3070207@namesys.com>
Date: Sat, 20 Nov 2004 18:41:10 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       vs <vs@thebsh.namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
References: <16797.41728.984065.479474@samba.org>	<419E1297.4080400@namesys.com>	<16798.31565.306237.930372@samba.org>	<419ECAB5.10203@namesys.com>	<16798.59519.63931.494579@samba.org>	<419F6D1F.10001@namesys.com> <16799.57253.861765.512175@samba.org>
In-Reply-To: <16799.57253.861765.512175@samba.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:

>Hans,
>
>A bit more information about the slowdown between runs (and eventual
>lockup) with reiser4 that I reported in my last email.
>
>I found that a umount/mount between runs solved the problem, leading
>to a fairly consistent result and no lockup. I also found that running
>a simple /bin/sync between runs solved the problem.
>
>This implies to me that it is some in-memory structure that is the
>culprit. I can't see anything obvious in /proc/slabinfo, but its been
>a while since I've done any serious kernel development so maybe I just
>don't know what to look for.
>
>I also tried enabling the "strict sync" option in Samba4. This makes
>the 1% flush operations in the load file map to fsync() instead of a
>noop. This caused reiser4 to lockup almost immediately, with the same
>symptoms as the previous lockups I reported (all smbd processes stuck
>in D state). No oops messages or anything unusual in dmesg.
>
>Cheers, Tridge
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Thanks much tridge.  vs, please respond in detail.
