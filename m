Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267153AbUBSKFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267155AbUBSKFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:05:24 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:25875 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S267153AbUBSKFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:05:18 -0500
Message-ID: <40348D70.8090103@aitel.hist.no>
Date: Thu, 19 Feb 2004 11:18:24 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: tridge@samba.org
CC: "Theodore Ts'o" <tytso@mit.edu>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
References: <1qqzv-2tr-3@gated-at.bofh.it>	<1qqJc-2A2-5@gated-at.bofh.it>	<1qHAR-2Wm-49@gated-at.bofh.it>	<1qIwr-5GB-11@gated-at.bofh.it>	<1qIwr-5GB-9@gated-at.bofh.it>	<1qIQ1-5WR-27@gated-at.bofh.it>	<1qIZt-6b9-11@gated-at.bofh.it>	<1qJsF-6Be-45@gated-at.bofh.it>	<E1Atbi7-0004tf-O7@localhost>	<16436.2817.900018.285167@samba.org>	<20040219024426.GA3901@thunk.org> <16436.11148.231014.822067@samba.org>
In-Reply-To: <16436.11148.231014.822067@samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
> Ted,
> 
>  > Actually, not necessarily.  What if Samba gets notifications of all
>  > filename renames and creates in the directory, so that after the
>  > initial directory scan, it can keep track of what filenames are
>  > present in the directory?  It can then "prove the negative", as you
>  > put it, without having to continuously do directory scans.
> 
> Currently dnotify doesn't give you the filename that is being
> added/deleted/renamed. It just tells you that something has happened,
> but not enough to actually maintain a name cache in user space.
> 
You can still keep per-directory caches that you simply invalidate on each dnotify,
and rebuild when necessary.  At least it would help the "repeated
lookup of nonexistant filenames" case.  
Path searches for executables usually happens on directories that don't 
see much writing.

Helge Hafting

