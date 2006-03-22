Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbWCVVKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWCVVKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWCVVKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:10:31 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24787 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932730AbWCVVKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:10:31 -0500
Message-ID: <4421BD35.7070702@sgi.com>
Date: Wed, 22 Mar 2006 22:10:13 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] notifier chain initialization
References: <Pine.LNX.4.44L0.0603221203210.5159-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0603221203210.5159-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
>> The benefit is that one can use the FOO_NOTIFIER_INIT() macro for
>> static initialization of a notifier chain.
> 
> You probably mean _dynamic_ initialization of a notifier head.  The 
> current code handles static initialization just fine.

Actually I meant static, I have a notifier declared within a struct and
a macro that initializes it at compile time - didn't work with the old
code.

But I also use it dynamically where this also benefits it.

> There's nothing wrong with doing things like this.  I didn't include 
> initialization macros originally simply because there aren't any 
> dynamically-initialized notifier heads in the kernel.

There probably will be :)

Cheers,
Jes
