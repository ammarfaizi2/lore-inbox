Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269414AbUJFTsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269414AbUJFTsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUJFTsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:48:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:28547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269416AbUJFTrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:47:19 -0400
Date: Wed, 6 Oct 2004 12:39:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: nickpiggin@yahoo.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Default cache_hot_time value back to 10ms
Message-Id: <20041006123959.4cf20b3b.akpm@osdl.org>
In-Reply-To: <200410061927.i96JRU607630@unix-os.sc.intel.com>
References: <20041005215116.3b0bd028.akpm@osdl.org>
	<200410061927.i96JRU607630@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Andrew Morton wrote on Tuesday, October 05, 2004 9:51 PM
>  > > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>  > >  I'd say it is probably too low level to be a useful tunable (although
>  > >  for testing I guess so... but then you could have *lots* of parameters
>  > >  tunable).
>  >
>  > This tunable caused an 11% performance difference in (I assume) TPCx.
>  > That's a big deal, and people will want to diddle it.
>  >
>  > If one number works optimally for all machines and workloads then fine.
>  >
>  > But yes, avoiding a tunable would be nice, but we need a tunable to work
>  > out whether we can avoid making it tunable ;)
>  >
>  > Not that I'm soliciting patches or anything.  I'll duck this one for now.
> 
>  Andrew, can I safely interpret this response as you are OK with having
>  cache_hot_time set to 10 ms for now?

I have a lot of scheduler changes queued up and I view this change as being
not very high priority.  If someone sends a patch to update -mm then we can
run with that, however Ingo's auto-tuning seems a far preferable approach.

>  And you will merge this change for 2.6.9?

I was not planning on doing so, but could be persuaded, I guess.

It's very, very late for this and subtle CPU scheduler regressions tend to
take a long time (weeks or months) to be identified.
