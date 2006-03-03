Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWCCRY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWCCRY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWCCRY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:24:58 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21461 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1030235AbWCCRY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:24:58 -0500
Message-ID: <44087BE7.4000908@namesys.com>
Date: Fri, 03 Mar 2006 09:24:55 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Reiserfs-List@namesys.com,
       green@linuxhacker.ru
Subject: Re: [Fwd: Re: [PATCH] reiserfs: use balance_dirty_pages_ratelimited_nr
 in reiserfs_file_write]
References: <4407386D.4070008@namesys.com> <20060302150859.51ffb93f.akpm@osdl.org>
In-Reply-To: <20060302150859.51ffb93f.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>I suspect that when someone did the search and replace when creating
>>balance_dirty_pages_ratelimited_nr they failed to read the code and
>>realize this code path was already effectively ratelimited.  The result
>>is they made it excessively infrequent (every 1MB if ratelimit is 8) in
>>its calling balance_dirty_pages.
>>    
>>
>
>??  There's been no change to balance_dirty_pages_ratelimited().  I merely
>widened the interface a bit: introduced the new
>balance_dirty_pages_ratelimited_nr() and did
>
>  
>
So we were not originally using balance_dirty() in place of
balance_dirty_pages_ratelimited?

At any rate, the change is obviously better, I think we all agree on that.
