Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWD0Hr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWD0Hr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWD0Hr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:47:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5956 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932426AbWD0Hr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:47:58 -0400
Date: Thu, 27 Apr 2006 09:47:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060427074751.GK9211@suse.de>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <20060426191557.GA9211@suse.de> <20060426131200.516cbabc.akpm@osdl.org> <20060427074533.GJ9211@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427074533.GJ9211@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27 2006, Jens Axboe wrote:
> Things look pretty bad for the lockless kernel though, Nick any idea
> what is going on there? The splice change is pretty simple, see the top
> three patches here:

Oh, I think I spotted something silly after all, the gang splice patch
is buggy. Let me fix that up and retest.

-- 
Jens Axboe

