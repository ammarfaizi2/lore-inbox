Return-Path: <linux-kernel-owner+w=401wt.eu-S1755298AbXABUY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbXABUY6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbXABUY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:24:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61508 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298AbXABUY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:24:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=E0NolByQW1cTMHEdINI/99W7Wgqg8O9RJAnaiPyQmhvQpz2nw8IfLcLMkFPHLo0mUZSrylpLuhidxZHfGRFAWad/UUwfklLnQaMFd0o18Zr0O/L29VCFAF57KUHcy9Sz536k92+h+CfzRNNTjlqUhvM8mIWs/jqr+6Fl8Bg6mSM=
Message-ID: <84144f020701021224x12390e0ao6277e734a31c1439@mail.gmail.com>
Date: Tue, 2 Jan 2007 22:24:56 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH] slab: add missing debug_check_no_locks_freed for kmem_cache_free
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20070102170627.GC25271@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701021838230.24781@sbz-30.cs.Helsinki.FI>
	 <20070102170627.GC25271@elte.hu>
X-Google-Sender-Auth: 17914bfeea988612
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> > Add a missing debug_check_no_locks_freed() debug check for
> > kmem_cache_free().

On 1/2/07, Ingo Molnar <mingo@elte.hu> wrote:
> hm, i have a similar fix in -rt already, and i sent a patch for this:
>
>  http://lkml.org/lkml/2006/12/18/104
>
> have i missed some API variant?

Oh, I missed that. I don't think it's in Linus' tree yet, though. Your
patch looks good but I prefer mine as it's better to have the check in
one place.
