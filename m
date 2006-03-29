Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWC2VhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWC2VhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWC2VhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:37:22 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:25962 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750973AbWC2VhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:37:21 -0500
Message-ID: <BAYC1-PASMTP04461710F02B72A8DF0685B9D00@CEZ.ICE>
X-Originating-IP: [70.48.9.102]
X-Originating-Email: [johnmccuthan@sympatico.ca]
Subject: Re: [PATCH] inotify: IN_DELETE events missing in -mm
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Amy Griffis <amy.griffis@hp.com>
Cc: linux-kernel@vger.kernel.org, John McCutchan <ttb@tentacle.dhs.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20060329155719.GA22092@zk3.dec.com>
References: <20060329155719.GA22092@zk3.dec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Mar 2006 16:37:22 -0500
Message-Id: <1143668243.22134.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-OriginalArrivalTime: 29 Mar 2006 21:37:21.0018 (UTC) FILETIME=[F5B63DA0:01C65378]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-29-03 at 10:57 -0500, Amy Griffis wrote:
> In recent -mm kernels (e.g. 2.6.16-mm1), IN_DELETE events are no longer 
> generated for the removal of a file from a watched directory.
> 
> This seems to be a result of clearing DCACHE_INOTIFY_PARENT_WATCHED in
> d_delete() directly before calling fsnotify_nameremove().
> 
> Assuming the flag doesn't need to be cleared before dentry_iput(), this should
> do the trick.

I took a quick look at nick's patch again, and it doesn't seem to
require the flag being cleared before dentry_iput. This looks good to
me. Nick?

-- 
John McCutchan <john@johnmccutchan.com>
