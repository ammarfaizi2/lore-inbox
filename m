Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUACBJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 20:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUACBJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 20:09:35 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:41406 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265856AbUACBJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 20:09:32 -0500
Date: Fri, 2 Jan 2004 17:09:09 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Message-ID: <20040103010909.GI1882@matchmail.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <3FE492EF.2090202@colorfullife.com> <20031221113640.GF3438@mail.shareable.org> <3FE594D0.8000807@colorfullife.com> <20031221141456.GI3438@mail.shareable.org> <3FF5DF59.3090905@tmr.com> <20040102224150.GA5864@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102224150.GA5864@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 10:41:50PM +0000, Jamie Lokier wrote:
> The best way is to maintain poll state in each "struct file".  The
> order of complexity for the bitmap scan is still significant, but
> ->poll calls are limited to the number of transitions which actually
> happen.

What's the drawback to this approach?

Where is the poll state kept now?

> I think somebody, maybe Richard Gooch, has a patch to do this that's
> several years old by now.

Why wasn't it merged?  

Implementation issues?
