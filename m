Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWBIQze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWBIQze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWBIQze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:55:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44492 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932481AbWBIQzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:55:33 -0500
Date: Thu, 9 Feb 2006 08:55:01 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marc Koschewski <marc@osknowledge.org>
Cc: marc@osknowledge.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH GIT] drivers/block/ub.c - misc. cleanup/indentation,
 removed unneeded return
Message-Id: <20060209085501.0a29c7e7.zaitcev@redhat.com>
In-Reply-To: <20060209092143.GA5676@stiffy.osknowledge.org>
References: <mailman.1139418724.17734.linux-kernel2news@redhat.com>
	<20060208194057.55b02719.zaitcev@redhat.com>
	<20060209092143.GA5676@stiffy.osknowledge.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006 10:21:43 +0100, Marc Koschewski <marc@osknowledge.org> wrote:

> > But the rest is quite bad, the worst being indenting the switch statement.
> 
> I see. Why do you use if-statement-indenting then?

Insides of case blocks are indented, didn't you notice? Why waste a tab?

> What is the sense of the empty comments? What sense does the 'immediate
> return' make when the value is returned 2 lines below (where one line is just
> a closing brace)?

Empty comments segregate related groups of functions.

The return is there in case something else is needed between the if and
the function's end. It's there to underscore the regular structure of the
code. Though the big block comment obscures the intent there. Perhaps
I should relocate it.

You didn't mention empty lines on top of functions. They appear where
variables are likely to be, or if the function body has a break, to make
it fair to all little segments :-)

> > Is there nothing else you can do in the whole kernel?
> 
> Sure, but I guess you don't have to tell me what files I put my nose in, do
> you? I didn't mean to personally piss you off by sending this in. Tzzz ...
> 
> Unfortunately my understanding of how ie. the Linux VM works is not very good.
> In fact it's poor. But I will dig into this and try to make even you happy with
> a patch that makes sense _in your eyes_.

I don't know anything about VM either and I do not see how this is
relevant.

The bigger point is, if you strive to make a meaningful contribution,
meaningless code rearrangements is not the way to go about it. And
we have plenty of work under the subsystem level, though usually it
has something to do with specific hardware. For example, Firewire
appears to be in dire need of fixing right now.

I remember a period of time when the janitoring project produced
meaningful cleanups, such as verification of failure paths. This work
is still relevant. Just the other day I sent a patch to Dmitry for
a leak in mousedev. And remember the debacle of memset(p, size, 0)!
I'm not going to tell you where to put your nose in, but I would like
to hint that the janitoring project might use some help with something
going beyond the uglification of my pretty code :-)

-- Pete
