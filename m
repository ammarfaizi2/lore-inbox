Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWACWWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWACWWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWACWWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:22:42 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:36842 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751489AbWACWWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:22:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MLJwiLSxuBhvRChVH7ewHFaZBW+siDTP+RyUFgGrbJlObqCeKwBZQAbR8dKS+sV2IDXjdTwbEWdW0LlaBcEBxojeoj0dbJHyWOU7DqXIeP1PNmTGske4ofnQIUJN/PdC1M7eE2pmiR5+bLad6LXTuyuV/G1mWW62lyPl7f/7ptA=
Message-ID: <9a8748490601031422x2cd586f3vd8849723b659820e@mail.gmail.com>
Date: Tue, 3 Jan 2006 23:22:41 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets on the stack
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200601032158.14057.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601032158.14057.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Andi Kleen <ak@suse.de> wrote:
> This is a RFC for now. I would be interested in testing
> feedback. Patch is for 2.6.15.
>
> Optimize select and poll by a using stack space for small fd sets
>
> This brings back an old optimization from Linux 2.0. Using
> the stack is faster than kmalloc. On a Intel P4 system
[snip]

Got an easy way to benchmark this?
I'd like to test it on my box and provide some feedback, but I'd need
a way to benchmark, and if you have an easy way to do that already
figured out it would save me having to write my own :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
